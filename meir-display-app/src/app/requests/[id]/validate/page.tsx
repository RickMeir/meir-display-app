'use client';

import { useEffect, useState } from 'react';
import { useRouter, useParams } from 'next/navigation';
import { AlertCircle, CheckCircle, XCircle, Loader2 } from 'lucide-react';
import { createClient } from '@/lib/supabase/client';
import { formatCurrency, formatPercent } from '@/lib/calculations';

interface RequestData {
  id: string;
  store_name: string;
  store_code: string;
  rep_name: string;
  brand_tier: string;
  display_type: string;
  display_reason: string;
  submitted_date: string;
  status: string;
  rebate_percent: number;
  cogs_percent: number;
  board_and_labour: number;
  forecast_revenue_12mo: number;
  rep_hours: number;
  free_samples: number;
  catalogues: number;
  product_cogs: number;
  total_investment: number;
  skus: Array<{ code: string; name: string }>;
  financial_assessment?: {
    revenue_after_discount: number;
    rebate_cost: number;
    cogs_on_sales: number;
    estimated_orders: number;
    order_processing_cost: number;
    rep_visit_cost: number;
    catalogue_cost: number;
    total_costs: number;
    gross_profit: number;
    gross_margin_percent: number;
    net_contribution: number;
    net_margin_percent: number;
  };
}

export default function ValidatePage() {
  const router = useRouter();
  const params = useParams();
  const [request, setRequest] = useState<RequestData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [submitting, setSubmitting] = useState(false);
  const [queryNote, setQueryNote] = useState('');
  const [queryError, setQueryError] = useState<string | null>(null);

  const requestId = params?.id as string;

  useEffect(() => {
    const fetchRequest = async () => {
      if (!requestId) {
        setError('No request ID provided');
        setLoading(false);
        return;
      }

      try {
        const response = await fetch(`/api/requests/${requestId}`);
        if (!response.ok) {
          throw new Error('Failed to fetch request');
        }
        const data = await response.json();
        setRequest(data);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'An error occurred');
      } finally {
        setLoading(false);
      }
    };

    fetchRequest();
  }, [requestId]);

  const handleValidate = async () => {
    setSubmitting(true);
    try {
      const response = await fetch(`/api/requests/${requestId}/validate`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ action: 'validate', note: null }),
      });

      if (!response.ok) {
        throw new Error('Validation failed');
      }

      router.push('/dashboard?message=Request%20validated%20successfully');
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    } finally {
      setSubmitting(false);
    }
  };

  const handleQuery = async () => {
    if (!queryNote.trim()) {
      setQueryError('Query note is required');
      return;
    }

    setSubmitting(true);
    setQueryError(null);

    try {
      const response = await fetch(`/api/requests/${requestId}/validate`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ action: 'query', note: queryNote }),
      });

      if (!response.ok) {
        throw new Error('Query submission failed');
      }

      router.push('/dashboard?message=Query%20submitted%20successfully');
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    } finally {
      setSubmitting(false);
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <Loader2 className="w-8 h-8 animate-spin text-blue-600" />
      </div>
    );
  }

  if (!request) {
    return (
      <div className="min-h-screen bg-gray-50 p-6">
        <div className="max-w-4xl mx-auto">
          <div className="bg-white rounded-lg shadow-md p-8">
            <div className="flex items-center gap-4 text-red-600">
              <XCircle className="w-8 h-8" />
              <p>{error || 'Request not found'}</p>
            </div>
          </div>
        </div>
      </div>
    );
  }

  if (request.status !== 'submitted') {
    return (
      <div className="min-h-screen bg-gray-50 p-6">
        <div className="max-w-4xl mx-auto">
          <div className="bg-white rounded-lg shadow-md p-8">
            <div className="flex items-center gap-4 text-amber-600">
              <AlertCircle className="w-8 h-8" />
              <div>
                <p className="font-semibold">Request Already Processed</p>
                <p className="text-sm mt-2">
                  This request has a status of <span className="font-mono">{request.status}</span> and cannot be validated.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }

  const assessment = request.financial_assessment;
  const isNetContributionHealthy = assessment && assessment.net_contribution >= 5000;
  const isNetMarginHealthy = assessment && assessment.net_margin_percent >= 15;
  const dealStatus = assessment && isNetContributionHealthy && isNetMarginHealthy ? 'GREEN' : 'REVIEW';

  return (
    <div className="min-h-screen bg-gray-50 p-6">
      <div className="max-w-6xl mx-auto">
        {/* Header */}
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-gray-900">Validation Review</h1>
          <p className="text-gray-600 mt-2">Request ID: {requestId}</p>
        </div>

        {error && (
          <div className="mb-6 bg-red-50 border border-red-200 rounded-lg p-4 flex items-center gap-4">
            <XCircle className="w-5 h-5 text-red-600 flex-shrink-0" />
            <p className="text-red-700">{error}</p>
          </div>
        )}

        {/* Request Details Card */}
        <div className="bg-white rounded-lg shadow-md p-6 mb-6">
          <h2 className="text-xl font-semibold text-gray-900 mb-6">Request Details</h2>
          <div className="grid grid-cols-2 gap-6">
            <div>
              <p className="text-sm text-gray-600">Store Name</p>
              <p className="text-lg font-semibold text-gray-900">{request.store_name}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Store Code</p>
              <p className="text-lg font-semibold text-gray-900">{request.store_code}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Rep Name</p>
              <p className="text-lg font-semibold text-gray-900">{request.rep_name}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Brand Tier</p>
              <p className="text-lg font-semibold text-gray-900">{request.brand_tier}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Display Type</p>
              <p className="text-lg font-semibold text-gray-900">{request.display_type}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Display Reason</p>
              <p className="text-lg font-semibold text-gray-900">{request.display_reason}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Submitted Date</p>
              <p className="text-lg font-semibold text-gray-900">
                {new Date(request.submitted_date).toLocaleDateString('en-GB')}
              </p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Status</p>
              <div className="mt-1">
                <span className="inline-block bg-blue-100 text-blue-800 px-3 py-1 rounded-full text-sm font-semibold">
                  {request.status.charAt(0).toUpperCase() + request.status.slice(1)}
                </span>
              </div>
            </div>
          </div>
        </div>

        {/* Financial Inputs Card */}
        <div className="bg-white rounded-lg shadow-md p-6 mb-6">
          <h2 className="text-xl font-semibold text-gray-900 mb-6">Financial Inputs</h2>
          <div className="grid grid-cols-3 gap-6">
            <div>
              <p className="text-sm text-gray-600">Rebate %</p>
              <p className="text-lg font-semibold text-gray-900">{formatPercent(request.rebate_percent)}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">COGS %</p>
              <p className="text-lg font-semibold text-gray-900">{formatPercent(request.cogs_percent)}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Board and Labour</p>
              <p className="text-lg font-semibold text-gray-900">{formatCurrency(request.board_and_labour)}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Forecast Revenue 12 months</p>
              <p className="text-lg font-semibold text-gray-900">{formatCurrency(request.forecast_revenue_12mo)}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Rep Hours</p>
              <p className="text-lg font-semibold text-gray-900">{request.rep_hours}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Free Samples</p>
              <p className="text-lg font-semibold text-gray-900">{request.free_samples}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Catalogues</p>
              <p className="text-lg font-semibold text-gray-900">{request.catalogues}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Product COGS</p>
              <p className="text-lg font-semibold text-gray-900">{formatCurrency(request.product_cogs)}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Total Investment</p>
              <p className="text-lg font-semibold text-gray-900">{formatCurrency(request.total_investment)}</p>
            </div>
          </div>
        </div>

        {/* Financial Assessment Card */}
        {assessment && (
          <div className="bg-white rounded-lg shadow-md p-6 mb-6">
            <h2 className="text-xl font-semibold text-gray-900 mb-6">Financial Assessment</h2>

            {/* Deal Status Badge */}
            <div className="mb-6 flex items-center gap-4">
              <div>
                <p className="text-sm text-gray-600 mb-2">Deal Status</p>
                <span
                  className={`inline-block px-4 py-2 rounded-full font-semibold text-white ${
                    dealStatus === 'GREEN' ? 'bg-green-600' : 'bg-red-600'
                  }`}
                >
                  {dealStatus}
                </span>
              </div>
              <div className="text-sm text-gray-600">
                {dealStatus === 'GREEN'
                  ? 'This deal meets all viability thresholds'
                  : 'This deal requires further review'}
              </div>
            </div>

            {/* Assessment Details */}
            <div className="space-y-4">
              {/* Row 1 */}
              <div className="grid grid-cols-3 gap-6 pb-4 border-b border-gray-200">
                <div>
                  <p className="text-sm text-gray-600">Revenue After Discount</p>
                  <p className="text-lg font-semibold text-gray-900">{formatCurrency(assessment.revenue_after_discount)}</p>
                </div>
                <div>
                  <p className="text-sm text-gray-600">Rebate Cost</p>
                  <p className="text-lg font-semibold text-gray-900">{formatCurrency(assessment.rebate_cost)}</p>
                </div>
                <div>
                  <p className="text-sm text-gray-600">COGS on Sales</p>
                  <p className="text-lg font-semibold text-gray-900">{formatCurrency(assessment.cogs_on_sales)}</p>
                </div>
              </div>

              {/* Row 2 */}
              <div className="grid grid-cols-3 gap-6 pb-4 border-b border-gray-200">
                <div>
                  <p className="text-sm text-gray-600">Estimated Orders</p>
                  <p className="text-lg font-semibold text-gray-900">{assessment.estimated_orders}</p>
                </div>
                <div>
                  <p className="text-sm text-gray-600">Order Processing Cost</p>
                  <p className="text-lg font-semibold text-gray-900">{formatCurrency(assessment.order_processing_cost)}</p>
                </div>
                <div>
                  <p className="text-sm text-gray-600">Rep Visit Cost (annual)</p>
                  <p className="text-lg font-semibold text-gray-900">{formatCurrency(assessment.rep_visit_cost)}</p>
                </div>
              </div>

              {/* Row 3 */}
              <div className="grid grid-cols-3 gap-6 pb-4 border-b border-gray-200">
                <div>
                  <p className="text-sm text-gray-600">Catalogue Cost</p>
                  <p className="text-lg font-semibold text-gray-900">{formatCurrency(assessment.catalogue_cost)}</p>
                </div>
                <div>
                  <p className="text-sm text-gray-600">Total Costs</p>
                  <p className="text-lg font-semibold text-gray-900 text-amber-600">{formatCurrency(assessment.total_costs)}</p>
                </div>
                <div>
                  <p className="text-sm text-gray-600">Gross Profit</p>
                  <p className="text-lg font-semibold text-gray-900">{formatCurrency(assessment.gross_profit)}</p>
                </div>
              </div>

              {/* Row 4 */}
              <div className="grid grid-cols-3 gap-6 pb-4 border-b border-gray-200">
                <div>
                  <p className="text-sm text-gray-600">Gross Margin %</p>
                  <p className="text-lg font-semibold text-gray-900">{formatPercent(assessment.gross_margin_percent)}</p>
                </div>
                <div>
                  <p className="text-sm text-gray-600">Net Contribution</p>
                  <p
                    className={`text-lg font-semibold ${
                      isNetContributionHealthy ? 'text-green-600' : 'text-red-600'
                    }`}
                  >
                    {formatCurrency(assessment.net_contribution)}
                  </p>
                  <p className="text-xs text-gray-500 mt-1">
                    {isNetContributionHealthy ? 'Above' : 'Below'} GBP 5,000 threshold
                  </p>
                </div>
                <div>
                  <p className="text-sm text-gray-600">Net Margin %</p>
                  <p
                    className={`text-lg font-semibold ${
                      isNetMarginHealthy ? 'text-green-600' : 'text-red-600'
                    }`}
                  >
                    {formatPercent(assessment.net_margin_percent)}
                  </p>
                  <p className="text-xs text-gray-500 mt-1">
                    {isNetMarginHealthy ? 'Above' : 'Below'} 15% threshold
                  </p>
                </div>
              </div>
            </div>
          </div>
        )}

        {/* SKUs Card */}
        {request.skus && request.skus.length > 0 && (
          <div className="bg-white rounded-lg shadow-md p-6 mb-6">
            <h2 className="text-xl font-semibold text-gray-900 mb-6">SKUs</h2>
            <div className="space-y-2">
              {request.skus.map((sku, index) => (
                <div key={index} className="flex items-center gap-4 py-2 border-b border-gray-100 last:border-0">
                  <div className="font-mono text-sm font-semibold text-gray-900">{sku.code}</div>
                  <div className="text-gray-700">{sku.name}</div>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Actions Section */}
        <div className="bg-white rounded-lg shadow-md p-6">
          <h2 className="text-xl font-semibold text-gray-900 mb-6">Actions</h2>

          <div className="space-y-6">
            {/* Validate Button */}
            <div>
              <button
                onClick={handleValidate}
                disabled={submitting}
                className="w-full bg-green-600 hover:bg-green-700 disabled:bg-gray-400 text-white font-semibold py-3 px-6 rounded-lg transition-colors flex items-center justify-center gap-2"
              >
                {submitting ? (
                  <>
                    <Loader2 className="w-5 h-5 animate-spin" />
                    Validating...
                  </>
                ) : (
                  <>
                    <CheckCircle className="w-5 h-5" />
                    Validate and Proceed
                  </>
                )}
              </button>
              <p className="text-sm text-gray-600 mt-2">
                Confirms inputs are correct and routes to financial approver
              </p>
            </div>

            {/* Query Section */}
            <div className="pt-6 border-t border-gray-200">
              <label className="block text-sm font-semibold text-gray-900 mb-3">
                Query Note <span className="text-red-600">*</span>
              </label>
              <textarea
                value={queryNote}
                onChange={(e) => {
                  setQueryNote(e.target.value);
                  setQueryError(null);
                }}
                placeholder="Enter your query or clarification request..."
                className="w-full border border-gray-300 rounded-lg p-3 focus:ring-2 focus:ring-orange-500 focus:border-transparent resize-none h-32"
              />
              {queryError && <p className="text-red-600 text-sm mt-2">{queryError}</p>}
              <button
                onClick={handleQuery}
                disabled={submitting || !queryNote.trim()}
                className="mt-4 w-full bg-orange-600 hover:bg-orange-700 disabled:bg-gray-400 text-white font-semibold py-3 px-6 rounded-lg transition-colors flex items-center justify-center gap-2"
              >
                {submitting ? (
                  <>
                    <Loader2 className="w-5 h-5 animate-spin" />
                    Submitting...
                  </>
                ) : (
                  'Submit Query'
                )}
              </button>
              <p className="text-sm text-gray-600 mt-2">
                Submits a query note for further clarification before validation
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
