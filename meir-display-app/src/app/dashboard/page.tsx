'use client';

import { Fragment, useEffect, useState } from 'react';
import Link from 'next/link';
import { useSearchParams } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';
import { formatCurrency, formatPercent, TIER_LABELS, VERDICT_LABELS } from '@/lib/calculations';
import { STATUS_LABELS, STATUS_COLOURS, type RequestStatus } from '@/lib/types';

interface DisplayRequest {
  id: string;
  store_name: string;
  store_code: string;
  rep_name: string;
  brand_tier: string | null;
  display_type: string | null;
  status: string;
  total_investment: number;
  forecast_revenue: number;
  net_contribution: number;
  net_margin: number;
  gross_profit: number;
  gross_margin: number;
  roi_multiplier: number | null;
  verdict: string | null;
  profitability_flag: string | null;
  approval_tier: string | null;
  approved_at: string | null;
  submitted_at: string | null;
  created_at: string;
  is_existing_client: boolean;
  existing_annual_revenue: number;
  incremental_revenue: number;
  revenue_after_discount: number;
  product_cogs: number;
  board_labour_cost: number;
  free_samples_cost: number;
  rep_visit_cost: number;
  catalogue_cost: number;
  total_costs: number;
}

interface MonthlyActual {
  month_year: string;
  revenue: number;
  catalogues_used: number;
}

type SortField = 'store_name' | 'total_investment' | 'net_contribution' | 'net_margin' | 'roi_multiplier' | 'forecast_revenue' | 'status';
type SortDir = 'asc' | 'desc';

export default function DashboardPage() {
  const supabase = createClient();
  const searchParams = useSearchParams();
  const message = searchParams.get('message');

  const [userRole, setUserRole] = useState<string | null>(null);
  const [requests, setRequests] = useState<DisplayRequest[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Sorting
  const [sortField, setSortField] = useState<SortField>('store_name');
  const [sortDir, setSortDir] = useState<SortDir>('asc');

  // Filter
  const [statusFilter, setStatusFilter] = useState<string>('approved');

  // Drill down
  const [expandedId, setExpandedId] = useState<string | null>(null);
  const [actuals, setActuals] = useState<Record<string, MonthlyActual[]>>({});
  const [loadingActuals, setLoadingActuals] = useState<string | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const { data: { user } } = await supabase.auth.getUser();
        if (!user) {
          setError('User not authenticated');
          setLoading(false);
          return;
        }

        const { data: userData } = await supabase
          .from('users')
          .select('role')
          .eq('id', user.id)
          .single();

        const role = userData?.role || 'rep';
        setUserRole(role);

        // Reps should not see this dashboard
        if (role === 'rep') {
          setLoading(false);
          return;
        }

        const res = await fetch('/api/requests?limit=500');
        if (!res.ok) throw new Error('Failed to fetch requests');
        const json = await res.json();
        setRequests(json.data || []);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'An error occurred');
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [supabase]);

  const fetchActuals = async (requestId: string) => {
    if (actuals[requestId]) return; // Already loaded
    setLoadingActuals(requestId);
    try {
      const res = await fetch(`/api/requests/${requestId}/lifecycle`);
      if (res.ok) {
        const json = await res.json();
        setActuals((prev) => ({ ...prev, [requestId]: json.monthly_actuals || [] }));
      }
    } catch {
      // Non critical — actuals section will show "no data" gracefully
    } finally {
      setLoadingActuals(null);
    }
  };

  const toggleExpand = (id: string) => {
    if (expandedId === id) {
      setExpandedId(null);
    } else {
      setExpandedId(id);
      fetchActuals(id);
    }
  };

  const handleSort = (field: SortField) => {
    if (sortField === field) {
      setSortDir(sortDir === 'asc' ? 'desc' : 'asc');
    } else {
      setSortField(field);
      setSortDir(field === 'store_name' ? 'asc' : 'desc');
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <p className="text-gray-600">Loading dashboard...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-gray-900 mb-4">Error</h1>
          <p className="text-gray-600">{error}</p>
        </div>
      </div>
    );
  }

  if (userRole === 'rep') {
    return (
      <div className="max-w-4xl mx-auto py-12 px-4">
        <h1 className="text-2xl font-bold text-gray-900 mb-4">Dashboard</h1>
        <p className="text-gray-600">Use the <Link href="/requests" className="text-blue-600 hover:underline">Requests</Link> page to view your display requests.</p>
      </div>
    );
  }

  // Filter and sort
  const filtered = requests.filter((r) => {
    if (statusFilter === 'all') return r.status !== 'draft';
    return r.status === statusFilter;
  });

  const sorted = [...filtered].sort((a, b) => {
    const dir = sortDir === 'asc' ? 1 : -1;
    const aVal = a[sortField] ?? 0;
    const bVal = b[sortField] ?? 0;
    if (typeof aVal === 'string' && typeof bVal === 'string') {
      return aVal.localeCompare(bVal) * dir;
    }
    return ((aVal as number) - (bVal as number)) * dir;
  });

  // Summary stats from approved displays
  const approved = requests.filter((r) => r.status === 'approved');
  const totalInvestment = approved.reduce((sum, r) => sum + (r.total_investment || 0), 0);
  const totalNetContribution = approved.reduce((sum, r) => sum + (r.net_contribution || 0), 0);
  const avgRoi = approved.length > 0
    ? approved.reduce((sum, r) => sum + (r.roi_multiplier || 0), 0) / approved.length
    : 0;
  const pendingValidation = requests.filter((r) => r.status === 'submitted').length;
  const pendingApproval = requests.filter((r) => r.status === 'pending_approval').length;
  const greenCount = approved.filter((r) => r.profitability_flag === 'green').length;
  const reviewCount = approved.filter((r) => r.profitability_flag === 'review').length;

  const isValidator = userRole === 'validator' || userRole === 'admin';
  const isApprover = ['manager', 'cfo', 'coo', 'admin'].includes(userRole || '');

  const SortHeader = ({ field, label }: { field: SortField; label: string }) => (
    <th
      className="text-left py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider cursor-pointer hover:text-gray-900 select-none whitespace-nowrap"
      onClick={() => handleSort(field)}
    >
      {label}
      {sortField === field && (
        <span className="ml-1">{sortDir === 'asc' ? '↑' : '↓'}</span>
      )}
    </th>
  );

  const verdictColour = (verdict: string | null) => {
    if (verdict === 'worth_it') return 'text-green-700 bg-green-50';
    if (verdict === 'marginal') return 'text-amber-700 bg-amber-50';
    return 'text-red-700 bg-red-50';
  };

  const flagColour = (flag: string | null) => {
    if (flag === 'green') return 'text-green-700';
    return 'text-red-600';
  };

  return (
    <div className="min-h-screen p-4 sm:p-8">
      <div className="max-w-full mx-auto">
        <div className="flex items-center justify-between mb-8">
          <div>
            <h1 className="text-3xl font-bold text-gray-900">Display Investment Register</h1>
            <p className="text-gray-500 mt-1">At a glance: is each display paying for itself?</p>
          </div>
          <Link
            href="/requests/new"
            className="bg-blue-600 hover:bg-blue-700 text-white font-medium px-4 py-2 rounded-lg text-sm transition-colors"
          >
            New Request
          </Link>
        </div>

        {message && (
          <div className="mb-6 rounded-lg bg-green-50 p-4 text-green-700 border border-green-200">
            <p className="text-sm">{message}</p>
          </div>
        )}

        {/* Summary Cards */}
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4 mb-8">
          <div className="bg-white rounded-lg shadow p-4 border border-gray-100">
            <p className="text-xs text-gray-500 uppercase tracking-wider">Active Displays</p>
            <p className="text-2xl font-bold text-gray-900 mt-1">{approved.length}</p>
          </div>
          <div className="bg-white rounded-lg shadow p-4 border border-gray-100">
            <p className="text-xs text-gray-500 uppercase tracking-wider">Total Investment</p>
            <p className="text-2xl font-bold text-gray-900 mt-1">{formatCurrency(totalInvestment)}</p>
          </div>
          <div className="bg-white rounded-lg shadow p-4 border border-gray-100">
            <p className="text-xs text-gray-500 uppercase tracking-wider">Total Net Contribution</p>
            <p className={`text-2xl font-bold mt-1 ${totalNetContribution >= 0 ? 'text-green-700' : 'text-red-600'}`}>
              {formatCurrency(totalNetContribution)}
            </p>
          </div>
          <div className="bg-white rounded-lg shadow p-4 border border-gray-100">
            <p className="text-xs text-gray-500 uppercase tracking-wider">Avg ROI</p>
            <p className="text-2xl font-bold text-gray-900 mt-1">{avgRoi.toFixed(1)}x</p>
          </div>
          <div className="bg-white rounded-lg shadow p-4 border border-gray-100">
            <p className="text-xs text-gray-500 uppercase tracking-wider">Profitability</p>
            <p className="mt-1">
              <span className="text-green-700 font-bold">{greenCount}</span>
              <span className="text-gray-400 mx-1">/</span>
              <span className="text-red-600 font-bold">{reviewCount}</span>
              <span className="text-xs text-gray-500 ml-1">green / review</span>
            </p>
          </div>
          <div className="bg-white rounded-lg shadow p-4 border border-gray-100">
            <p className="text-xs text-gray-500 uppercase tracking-wider">Pipeline</p>
            <p className="mt-1">
              {pendingValidation > 0 && (
                <span className="text-amber-600 font-bold mr-2">{pendingValidation} validating</span>
              )}
              {pendingApproval > 0 && (
                <span className="text-blue-600 font-bold">{pendingApproval} approving</span>
              )}
              {pendingValidation === 0 && pendingApproval === 0 && (
                <span className="text-gray-400">Clear</span>
              )}
            </p>
          </div>
        </div>

        {/* Status Filter */}
        <div className="flex gap-2 mb-4">
          {[
            { value: 'approved', label: 'Approved' },
            { value: 'pending_approval', label: 'Pending Approval' },
            { value: 'submitted', label: 'Awaiting Validation' },
            { value: 'rejected', label: 'Rejected' },
            { value: 'all', label: 'All' },
          ].map((f) => (
            <button
              key={f.value}
              onClick={() => setStatusFilter(f.value)}
              className={`px-3 py-1.5 rounded-full text-xs font-medium transition-colors ${
                statusFilter === f.value
                  ? 'bg-gray-900 text-white'
                  : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
              }`}
            >
              {f.label}
              <span className="ml-1 opacity-60">
                ({f.value === 'all'
                  ? requests.filter((r) => r.status !== 'draft').length
                  : requests.filter((r) => r.status === f.value).length})
              </span>
            </button>
          ))}
        </div>

        {/* Register Table */}
        <div className="bg-white rounded-lg shadow border border-gray-100 overflow-hidden">
          {sorted.length === 0 ? (
            <div className="p-8 text-center">
              <p className="text-gray-500">No displays match this filter.</p>
            </div>
          ) : (
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead>
                  <tr className="border-b border-gray-200 bg-gray-50">
                    <th className="w-8 py-3 px-2"></th>
                    <SortHeader field="store_name" label="Store" />
                    <th className="text-left py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">Rep</th>
                    <SortHeader field="total_investment" label="Investment" />
                    <SortHeader field="forecast_revenue" label="Forecast (12mo)" />
                    <SortHeader field="net_contribution" label="Net Contribution" />
                    <SortHeader field="net_margin" label="Net Margin" />
                    <SortHeader field="roi_multiplier" label="ROI" />
                    <th className="text-left py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">Verdict</th>
                    <th className="text-left py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">Flag</th>
                    <SortHeader field="status" label="Status" />
                    <th className="text-left py-3 px-4 text-xs font-semibold text-gray-600 uppercase tracking-wider">Action</th>
                  </tr>
                </thead>
                <tbody>
                  {sorted.map((req) => {
                    const isExpanded = expandedId === req.id;
                    const statusLabel = STATUS_LABELS[req.status as RequestStatus] || req.status;
                    const verdictLabel = req.verdict ? (VERDICT_LABELS as Record<string, string>)[req.verdict] || req.verdict : '';
                    const monthlyData = actuals[req.id] || [];
                    const totalActualRevenue = monthlyData.reduce((sum, m) => sum + m.revenue, 0);
                    const trackingPct = req.forecast_revenue > 0 && monthlyData.length > 0
                      ? (totalActualRevenue / (req.forecast_revenue * (monthlyData.length / 12))) * 100
                      : null;

                    // Determine action link
                    let actionHref = `/requests/${req.id}`;
                    let actionLabel = 'View';
                    if (req.status === 'submitted' && isValidator) {
                      actionHref = `/requests/${req.id}/validate`;
                      actionLabel = 'Validate';
                    } else if (req.status === 'pending_approval' && isApprover) {
                      actionHref = `/requests/${req.id}/approve`;
                      actionLabel = 'Approve';
                    }

                    return (
                      <Fragment key={req.id}>
                        <tr
                          className={`border-b border-gray-100 hover:bg-gray-50 transition-colors cursor-pointer ${isExpanded ? 'bg-blue-50' : ''}`}
                          onClick={() => toggleExpand(req.id)}
                        >
                          <td className="py-3 px-2 text-gray-400 text-xs">{isExpanded ? '▼' : '▶'}</td>
                          <td className="py-3 px-4">
                            <p className="text-sm font-medium text-gray-900">{req.store_name}</p>
                            {req.brand_tier && <p className="text-xs text-gray-500">{req.brand_tier}</p>}
                          </td>
                          <td className="py-3 px-4 text-sm text-gray-700">{req.rep_name}</td>
                          <td className="py-3 px-4 text-sm font-medium text-gray-900">{formatCurrency(req.total_investment)}</td>
                          <td className="py-3 px-4 text-sm text-gray-700">{formatCurrency(req.forecast_revenue)}</td>
                          <td className={`py-3 px-4 text-sm font-medium ${req.net_contribution >= 2000 ? 'text-green-700' : 'text-red-600'}`}>
                            {formatCurrency(req.net_contribution)}
                          </td>
                          <td className={`py-3 px-4 text-sm font-medium ${req.net_margin >= 0.15 ? 'text-green-700' : 'text-red-600'}`}>
                            {formatPercent(req.net_margin)}
                          </td>
                          <td className="py-3 px-4 text-sm font-bold text-gray-900">
                            {req.roi_multiplier != null ? `${req.roi_multiplier.toFixed(1)}x` : '—'}
                          </td>
                          <td className="py-3 px-4">
                            {verdictLabel && (
                              <span className={`inline-block px-2 py-0.5 rounded text-xs font-semibold ${verdictColour(req.verdict)}`}>
                                {verdictLabel}
                              </span>
                            )}
                          </td>
                          <td className={`py-3 px-4 text-sm font-semibold ${flagColour(req.profitability_flag)}`}>
                            {req.profitability_flag === 'green' ? 'GREEN' : req.profitability_flag === 'review' ? 'REVIEW' : '—'}
                          </td>
                          <td className="py-3 px-4">
                            <span className={`inline-block px-2 py-0.5 rounded text-xs font-medium ${
                              req.status === 'approved' ? 'bg-green-100 text-green-800' :
                              req.status === 'rejected' ? 'bg-red-100 text-red-800' :
                              req.status === 'pending_approval' ? 'bg-blue-100 text-blue-800' :
                              req.status === 'submitted' ? 'bg-amber-100 text-amber-800' :
                              'bg-gray-100 text-gray-700'
                            }`}>
                              {statusLabel}
                            </span>
                          </td>
                          <td className="py-3 px-4">
                            <Link
                              href={actionHref}
                              onClick={(e) => e.stopPropagation()}
                              className="text-blue-600 hover:text-blue-800 text-sm font-medium"
                            >
                              {actionLabel}
                            </Link>
                          </td>
                        </tr>

                        {/* Drill Down */}
                        {isExpanded && (
                          <tr className="bg-blue-50 border-b border-gray-200">
                            <td colSpan={12} className="px-8 py-6">
                              <div className="grid grid-cols-2 md:grid-cols-4 gap-6 mb-6">
                                <div>
                                  <p className="text-xs text-gray-500 uppercase tracking-wider">Revenue After Discount</p>
                                  <p className="text-lg font-semibold text-gray-900">{formatCurrency(req.revenue_after_discount)}</p>
                                </div>
                                <div>
                                  <p className="text-xs text-gray-500 uppercase tracking-wider">Gross Profit</p>
                                  <p className="text-lg font-semibold text-gray-900">{formatCurrency(req.gross_profit)}</p>
                                </div>
                                <div>
                                  <p className="text-xs text-gray-500 uppercase tracking-wider">Gross Margin</p>
                                  <p className="text-lg font-semibold text-gray-900">{formatPercent(req.gross_margin)}</p>
                                </div>
                                <div>
                                  <p className="text-xs text-gray-500 uppercase tracking-wider">Approval Tier</p>
                                  <p className="text-lg font-semibold text-gray-900">{TIER_LABELS[req.approval_tier || 'manager']}</p>
                                </div>
                              </div>

                              <div className="grid grid-cols-2 md:grid-cols-5 gap-6 mb-6">
                                <div>
                                  <p className="text-xs text-gray-500 uppercase tracking-wider">Product COGS</p>
                                  <p className="text-sm font-medium text-gray-900">{formatCurrency(req.product_cogs)}</p>
                                </div>
                                <div>
                                  <p className="text-xs text-gray-500 uppercase tracking-wider">Board and Labour</p>
                                  <p className="text-sm font-medium text-gray-900">{formatCurrency(req.board_labour_cost)}</p>
                                </div>
                                <div>
                                  <p className="text-xs text-gray-500 uppercase tracking-wider">Samples and Gifts</p>
                                  <p className="text-sm font-medium text-gray-900">{formatCurrency(req.free_samples_cost)}</p>
                                </div>
                                <div>
                                  <p className="text-xs text-gray-500 uppercase tracking-wider">Rep Visit Cost (annual)</p>
                                  <p className="text-sm font-medium text-gray-900">{formatCurrency(req.rep_visit_cost)}</p>
                                </div>
                                <div>
                                  <p className="text-xs text-gray-500 uppercase tracking-wider">Catalogue Cost</p>
                                  <p className="text-sm font-medium text-gray-900">{formatCurrency(req.catalogue_cost)}</p>
                                </div>
                              </div>

                              {req.is_existing_client && req.existing_annual_revenue > 0 && (
                                <div className="bg-blue-100 rounded p-3 mb-6">
                                  <p className="text-xs text-blue-800 font-medium">
                                    Existing Client — Current revenue: {formatCurrency(req.existing_annual_revenue)}.
                                    Incremental revenue from display: {formatCurrency(req.incremental_revenue)}.
                                  </p>
                                </div>
                              )}

                              {/* Monthly Actuals */}
                              <div>
                                <h4 className="text-sm font-semibold text-gray-900 mb-3">Monthly Actuals vs Forecast</h4>
                                {loadingActuals === req.id ? (
                                  <p className="text-sm text-gray-500">Loading actuals...</p>
                                ) : monthlyData.length === 0 ? (
                                  <p className="text-sm text-gray-500">No monthly actuals uploaded yet.</p>
                                ) : (
                                  <>
                                    <div className="overflow-x-auto">
                                      <table className="w-full text-sm">
                                        <thead>
                                          <tr className="border-b border-gray-200">
                                            <th className="text-left py-2 px-3 text-xs font-semibold text-gray-600">Month</th>
                                            <th className="text-right py-2 px-3 text-xs font-semibold text-gray-600">Actual Revenue</th>
                                            <th className="text-right py-2 px-3 text-xs font-semibold text-gray-600">Monthly Target</th>
                                            <th className="text-right py-2 px-3 text-xs font-semibold text-gray-600">Variance</th>
                                            <th className="text-right py-2 px-3 text-xs font-semibold text-gray-600">Catalogues</th>
                                          </tr>
                                        </thead>
                                        <tbody>
                                          {monthlyData
                                            .sort((a, b) => a.month_year.localeCompare(b.month_year))
                                            .map((m) => {
                                              const monthlyTarget = req.forecast_revenue / 12;
                                              const variance = monthlyTarget > 0
                                                ? ((m.revenue - monthlyTarget) / monthlyTarget) * 100
                                                : 0;
                                              return (
                                                <tr key={m.month_year} className="border-b border-gray-100">
                                                  <td className="py-2 px-3 text-gray-900">{m.month_year}</td>
                                                  <td className="py-2 px-3 text-right font-medium text-gray-900">{formatCurrency(m.revenue)}</td>
                                                  <td className="py-2 px-3 text-right text-gray-500">{formatCurrency(monthlyTarget)}</td>
                                                  <td className={`py-2 px-3 text-right font-medium ${variance >= 0 ? 'text-green-700' : 'text-red-600'}`}>
                                                    {variance >= 0 ? '+' : ''}{variance.toFixed(1)}%
                                                  </td>
                                                  <td className="py-2 px-3 text-right text-gray-700">{m.catalogues_used}</td>
                                                </tr>
                                              );
                                            })}
                                        </tbody>
                                        <tfoot>
                                          <tr className="border-t-2 border-gray-300 bg-gray-50">
                                            <td className="py-2 px-3 font-semibold text-gray-900">Total</td>
                                            <td className="py-2 px-3 text-right font-bold text-gray-900">{formatCurrency(totalActualRevenue)}</td>
                                            <td className="py-2 px-3 text-right font-medium text-gray-500">
                                              {formatCurrency((req.forecast_revenue / 12) * monthlyData.length)}
                                            </td>
                                            <td className={`py-2 px-3 text-right font-bold ${(trackingPct || 0) >= 100 ? 'text-green-700' : 'text-red-600'}`}>
                                              {trackingPct != null ? `${trackingPct.toFixed(1)}% of target` : '—'}
                                            </td>
                                            <td className="py-2 px-3 text-right font-medium text-gray-700">
                                              {monthlyData.reduce((sum, m) => sum + m.catalogues_used, 0)}
                                            </td>
                                          </tr>
                                        </tfoot>
                                      </table>
                                    </div>
                                  </>
                                )}
                              </div>

                              <div className="mt-4 flex gap-3">
                                <Link
                                  href={`/requests/${req.id}`}
                                  className="text-sm text-blue-600 hover:underline font-medium"
                                >
                                  Full details
                                </Link>
                                <Link
                                  href={`/requests/${req.id}/lifecycle`}
                                  className="text-sm text-blue-600 hover:underline font-medium"
                                >
                                  Lifecycle reviews
                                </Link>
                              </div>
                            </td>
                          </tr>
                        )}
                      </Fragment>
                    );
                  })}
                </tbody>
              </table>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
