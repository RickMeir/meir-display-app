'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import { createClient } from '@/lib/supabase/client';
import { formatCurrency } from '@/lib/calculations';
import { STATUS_LABELS, STATUS_COLOURS, type RequestStatus } from '@/lib/types';

interface Request {
  id: string;
  store_name: string;
  rep_name: string;
  total_investment: number;
  status: string;
  created_at: string;
}

interface SummaryCard {
  label: string;
  value: string | number;
  subtext?: string;
}

export default function DashboardPage() {
  const supabase = createClient();

  const [userRole, setUserRole] = useState<string | null>(null);
  const [requests, setRequests] = useState<Request[]>([]);
  const [summaryData, setSummaryData] = useState<{
    activeDisplays: number;
    totalInvestment: number;
    pendingValidation: number;
    pendingApproval: number;
  }>({
    activeDisplays: 0,
    totalInvestment: 0,
    pendingValidation: 0,
    pendingApproval: 0,
  });

  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchUserAndRequests = async () => {
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

        const requestsResponse = await fetch('/api/requests');
        if (!requestsResponse.ok) {
          throw new Error('Failed to fetch requests');
        }

        const requestsJson = await requestsResponse.json();
        const requestsData = requestsJson.data || [];
        setRequests(requestsData);

        const activeDisplays = requestsData.filter((r: Request) => r.status === 'approved').length;
        const totalInvestment = requestsData
          .filter((r: Request) => r.status === 'approved')
          .reduce((sum: number, r: Request) => sum + (r.total_investment || 0), 0);
        const pendingValidation = requestsData.filter((r: Request) => r.status === 'submitted').length;
        const pendingApproval = requestsData.filter((r: Request) => r.status === 'pending_approval').length;

        setSummaryData({
          activeDisplays,
          totalInvestment,
          pendingValidation,
          pendingApproval,
        });
      } catch (err) {
        setError(err instanceof Error ? err.message : 'An error occurred');
      } finally {
        setLoading(false);
      }
    };

    fetchUserAndRequests();
  }, [supabase]);

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-gray-50">
        <p className="text-gray-600">Loading dashboard...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-gray-50">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-gray-900 mb-4">Error</h1>
          <p className="text-gray-600">{error}</p>
        </div>
      </div>
    );
  }

  const isValidator = userRole === 'validator' || userRole === 'admin';
  const isApprover = ['manager', 'cfo', 'coo', 'admin'].includes(userRole || '');

  const summaryCards: SummaryCard[] = [
    {
      label: 'Total Active Displays',
      value: summaryData.activeDisplays,
    },
    {
      label: 'Total Investment',
      value: formatCurrency(summaryData.totalInvestment),
    },
  ];

  if (isValidator) {
    summaryCards.push({
      label: 'Pending Validation',
      value: summaryData.pendingValidation,
    });
  }

  if (isApprover) {
    summaryCards.push({
      label: 'Pending Approval',
      value: summaryData.pendingApproval,
    });
  }

  const canViewFinancials = userRole !== 'rep';

  const getActionLink = (request: Request) => {
    if (request.status === 'submitted' && isValidator) {
      return {
        label: 'Validate',
        href: `/requests/${request.id}/validate`,
      };
    }
    if (request.status === 'pending_approval' && isApprover) {
      return {
        label: 'Approve',
        href: `/requests/${request.id}/approve`,
      };
    }
    return {
      label: 'View',
      href: `/requests/${request.id}`,
    };
  };

  return (
    <div className="min-h-screen bg-gray-50 p-8">
      <div className="max-w-7xl mx-auto">
        <h1 className="text-4xl font-bold text-gray-900 mb-8">Dashboard</h1>

        {/* Summary Cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-12">
          {summaryCards.map((card, index) => (
            <div key={index} className="bg-gray-200 rounded-lg shadow-md p-6">
              <p className="text-sm text-gray-600 mb-2">{card.label}</p>
              <p className="text-3xl font-bold text-gray-900">{card.value}</p>
              {card.subtext && <p className="text-xs text-gray-500 mt-2">{card.subtext}</p>}
            </div>
          ))}
        </div>

        {/* Requests Table */}
        <div className="bg-gray-200 rounded-lg shadow-md overflow-hidden">
          <div className="p-6 border-b border-gray-200">
            <h2 className="text-2xl font-semibold text-gray-900">Recent Requests</h2>
          </div>

          {requests.length === 0 ? (
            <div className="p-8 text-center">
              <p className="text-gray-600">No requests found</p>
            </div>
          ) : (
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead>
                  <tr className="bg-gray-50 border-b border-gray-200">
                    <th className="text-left py-4 px-6 text-sm font-semibold text-gray-700">Store</th>
                    <th className="text-left py-4 px-6 text-sm font-semibold text-gray-700">Rep</th>
                    {canViewFinancials && (
                      <th className="text-left py-4 px-6 text-sm font-semibold text-gray-700">Investment</th>
                    )}
                    <th className="text-left py-4 px-6 text-sm font-semibold text-gray-700">Status</th>
                    <th className="text-left py-4 px-6 text-sm font-semibold text-gray-700">Date</th>
                    <th className="text-left py-4 px-6 text-sm font-semibold text-gray-700">Action</th>
                  </tr>
                </thead>
                <tbody>
                  {requests.map((request, index) => {
                    const action = getActionLink(request);
                    const statusColor = STATUS_COLOURS[request.status as RequestStatus] || 'gray';
                    const statusLabel = STATUS_LABELS[request.status as RequestStatus] || request.status;
                    const formattedDate = new Date(request.created_at).toLocaleDateString('en-GB', {
                      year: 'numeric',
                      month: 'short',
                      day: 'numeric',
                    });

                    return (
                      <tr
                        key={request.id}
                        className={index % 2 === 0 ? 'bg-gray-200' : 'bg-gray-100'}
                      >
                        <td className="py-4 px-6 text-sm text-gray-900">{request.store_name}</td>
                        <td className="py-4 px-6 text-sm text-gray-900">{request.rep_name}</td>
                        {canViewFinancials && (
                          <td className="py-4 px-6 text-sm text-gray-900">
                            {formatCurrency(request.total_investment)}
                          </td>
                        )}
                        <td className="py-4 px-6 text-sm">
                          <span
                            className={`inline-block px-3 py-1 rounded-full text-xs font-semibold bg-${statusColor}-100 text-${statusColor}-800`}
                          >
                            {statusLabel}
                          </span>
                        </td>
                        <td className="py-4 px-6 text-sm text-gray-900">{formattedDate}</td>
                        <td className="py-4 px-6 text-sm">
                          <Link
                            href={action.href}
                            className="text-blue-600 hover:text-blue-800 font-medium"
                          >
                            {action.label}
                          </Link>
                        </td>
                      </tr>
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
