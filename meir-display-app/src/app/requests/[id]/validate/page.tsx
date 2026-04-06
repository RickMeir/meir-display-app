'use client';

import { useEffect, useState } from 'react';
import { useRouter, useParams } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';
import { DisplayRequest, STATUS_LABELS } from '@/lib/types';
import { formatCurrency, formatPercent } from '@/lib/calculations';
import RequestOpportunity from '@/components/RequestOpportunity';

export default function ValidatePage() {
  const router = useRouter();
  const params = useParams();
  const [request, setRequest] = useState<DisplayRequest | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [submitting, setSubmitting] = useState(false);
  const [queryNote, setQueryNote] = useState('');
  const [queryError, setQueryError] = useState<string | null>(null);
  const [customerNameConfirmed, setCustomerNameConfirmed] = useState(false);

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
      <div className="flex items-center justify-center py-12">
        <p className="text-gray-600">Loading request...</p>
      </div>
    );
  }

  if (!request) {
    return (
      <div className="max-w-4xl mx-auto py-8">
        <div className="bg-gray-200 rounded-lg shadow p-8">
          <p className="text-red-600">{error || 'Request not found'}</p>
        </div>
      </div>
    );
  }

  if (request.status !== 'submitted') {
    return (
      <div className="max-w-4xl mx-auto py-8">
        <div className="bg-gray-200 rounded-lg shadow p-8">
          <p className="font-semibold text-amber-700">Request Already Processed</p>
          <p className="text-sm mt-2 text-gray-600">
            This request has a status of &quot;{STATUS_LABELS[request.status]}&quot; and cannot be validated.
          </p>
        </div>
      </div>
    );
  }

  const isNetContributionHealthy = request.net_contribution >= 5000;
  const isNetMarginHealthy = request.net_margin >= 0.15;
  const dealStatus = isNetContributionHealthy && isNetMarginHealthy ? 'GREEN' : 'REVIEW';

  return (
    <div className="max-w-6xl mx-auto space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-3xl font-bold text-gray-900">Validation Review</h1>
        <p className="text-gray-600 mt-2">{request.store_name} ({request.store_code})</p>
      </div>

      {error && (
        <div className="bg-red-50 border border-red-200 rounded-lg p-4">
          <p className="text-red-700">{error}</p>
        </div>
      )}

      {/* Request Details */}
      <div className="bg-gray-200 rounded-lg shadow p-6">
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
            <p className="text-sm text-gray-600">Rep</p>
            <p className="text-lg font-semibold text-gray-900">{request.rep_name}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Brand Tier</p>
            <p className="text-lg font-semibold text-gray-900">{request.brand_tier || '—'}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Display Type</p>
            <p className="text-lg font-semibold text-gray-900">{request.display_type || '—'}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Submitted</p>
            <p className="text-lg font-semibold text-gray-900">
              {new Date(request.submitted_at).toLocaleDateString('en-AU')}
            </p>
          </div>
          {request.display_reason && (
            <div className="col-span-2">
              <p className="text-sm text-gray-600">Display Reason</p>
              <p className="text-lg font-semibold text-gray-900">{request.display_reason}</p>
            </div>
          )}
        </div>
      </div>

      {/* Opportunity, Initial Order, Photos */}
      <RequestOpportunity request={request} />

      {/* Financial Inputs */}
      <div className="bg-gray-200 rounded-lg shadow p-6">
        <h2 className="text-xl font-semibold text-gray-900 mb-6">Financial Inputs</h2>
        <div className="grid grid-cols-3 gap-6">
          <div>
            <p className="text-sm text-gray-600">Rebate %</p>
            <p className="text-lg font-semibold text-gray-900">{formatPercent(request.rebate_pct)}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">COGS / Discount %</p>
            <p className="text-lg font-semibold text-gray-900">{formatPercent(request.cogs_pct)}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Board and Labour</p>
            <p className="text-lg font-semibold text-gray-900">{formatCurrency(request.board_labour_cost)}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">12 Month Sales Forecast</p>
            <p className="text-lg font-semibold text-gray-900">{formatCurrency(request.forecast_revenue)}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Rep Hours per Month</p>
            <p className="text-lg font-semibold text-gray-900">{request.rep_hours_monthly}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Free Samples and Gifts</p>
            <p className="text-lg font-semibold text-gray-900">{formatCurrency(request.free_samples_cost)}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Catalogues per Year</p>
            <p className="text-lg font-semibold text-gray-900">{request.catalogues_qty}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Display Product COGS</p>
            <p className="text-lg font-semibold text-gray-900">{formatCurrency(request.product_cogs)}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Total Investment</p>
            <p className="text-lg font-semibold text-gray-900">{formatCurrency(request.total_investment)}</p>
          </div>
        </div>
      </div>

      {/* Financial Assessment */}
      <div className="bg-gray-200 rounded-lg shadow p-6">
        <h2 className="text-xl font-semibold text-gray-900 mb-6">Financial Assessment</h2>

        {/* Deal Status Badge */}
        <div className="mb-6">
          <p className="text-sm text-gray-600 mb-2">Deal Status</p>
          <span
            className={`inline-block px-4 py-2 rounded-full font-semibold text-white ${
              dealStatus === 'GREEN' ? 'bg-green-600' : 'bg-red-600'
            }`}
          >
            {dealStatus === 'GREEN' ? 'GREEN — Viable' : 'REVIEW — Below Thresholds'}
          </span>
        </div>

        <div className="grid grid-cols-3 gap-6">
          <div>
            <p className="text-sm text-gray-600">Revenue After Discount</p>
            <p className="text-lg font-semibold text-gray-900">{formatCurrency(request.revenue_after_discount)}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Rebate Cost</p>
            <p className="text-lg font-semibold text-gray-900">{formatCurrency(request.rebate_cost)}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">COGS on Sales</p>
            <p className="text-lg font-semibold text-gray-900">{formatCurrency(request.cogs_on_sales)}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Estimated Orders</p>
            <p className="text-lg font-semibold text-gray-900">{request.est_orders}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Order Processing</p>
            <p className="text-lg font-semibold text-gray-900">{formatCurrency(request.order_processing)}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Rep Visit Cost (annual)</p>
            <p className="text-lg font-semibold text-gray-900">{formatCurrency(request.rep_visit_cost)}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Catalogue Cost</p>
            <p className="text-lg font-semibold text-gray-900">{formatCurrency(request.catalogue_cost)}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Total Costs</p>
            <p className="text-lg font-semibold text-amber-600">{formatCurrency(request.total_costs)}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Gross Profit</p>
            <p className="text-lg font-semibold text-gray-900">{formatCurrency(request.gross_profit)}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Gross Margin</p>
            <p className="text-lg font-semibold text-gray-900">{formatPercent(request.gross_margin)}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Net Contribution</p>
            <p className={`text-lg font-semibold ${isNetContributionHealthy ? 'text-green-600' : 'text-red-600'}`}>
              {formatCurrency(request.net_contribution)}
            </p>
            <p className="text-xs text-gray-500 mt-1">
              {isNetContributionHealthy ? 'Above' : 'Below'} $5,000 threshold
            </p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Net Margin</p>
            <p className={`text-lg font-semibold ${isNetMarginHealthy ? 'text-green-600' : 'text-red-600'}`}>
              {formatPercent(request.net_margin)}
            </p>
            <p className="text-xs text-gray-500 mt-1">
              {isNetMarginHealthy ? 'Above' : 'Below'} 15% threshold
            </p>
          </div>
        </div>
      </div>

      {/* SKUs */}
      {request.skus && request.skus.length > 0 && (
        <div className="bg-gray-200 rounded-lg shadow p-6">
          <h2 className="text-xl font-semibold text-gray-900 mb-4">SKUs</h2>
          <div className="space-y-2">
            {request.skus.map((sku) => (
              <div key={sku.id} className="flex items-center gap-4 py-2 border-b border-gray-100 last:border-0">
                <span className="font-mono text-sm font-semibold text-gray-900">{sku.sku_code}</span>
                <span className="text-gray-700">{sku.sku_name || '—'}</span>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Customer Name Verification */}
      <div className="bg-amber-50 border-2 border-amber-300 rounded-lg shadow p-6">
        <h2 className="text-xl font-semibold text-gray-900 mb-3">Customer Name Verification</h2>
        <p className="text-gray-700 mb-4">
          The store name below will be used to match sales data from Acumatica. It must match the
          customer name in Acumatica <strong>exactly</strong> — including spelling, spacing, and
          punctuation. If it does not match, sales will not be attributed to this display.
        </p>
        <div className="bg-white border border-gray-200 rounded-lg p-4 mb-4">
          <p className="text-sm text-gray-500">Store name on this request</p>
          <p className="text-2xl font-bold text-gray-900 mt-1">{request.store_name}</p>
          {request.store_code && (
            <p className="text-sm text-gray-500 mt-1">Store code: {request.store_code}</p>
          )}
        </div>
        <label className="flex items-start gap-3 cursor-pointer">
          <input
            type="checkbox"
            checked={customerNameConfirmed}
            onChange={(e) => setCustomerNameConfirmed(e.target.checked)}
            className="mt-1 h-5 w-5 rounded border-gray-300 text-blue-600 focus:ring-blue-500"
          />
          <span className="text-sm text-gray-700">
            I confirm this store name matches the customer name in Acumatica exactly. I understand
            that if this name is wrong, sales data will not be attributed to this display.
          </span>
        </label>
      </div>

      {/* Actions */}
      <div className="bg-gray-200 rounded-lg shadow p-6">
        <h2 className="text-xl font-semibold text-gray-900 mb-6">Actions</h2>

        <div className="space-y-6">
          {/* Validate Button */}
          <div>
            <button
              onClick={handleValidate}
              disabled={submitting || !customerNameConfirmed}
              className="w-full bg-green-600 hover:bg-green-700 disabled:bg-gray-400 text-white font-semibold py-3 px-6 rounded-lg transition-colors"
            >
              {submitting ? 'Validating...' : 'Validate and Proceed'}
            </button>
            {!customerNameConfirmed && (
              <p className="text-sm text-amber-600 mt-2 font-medium">
                You must confirm the customer name matches Acumatica before validating.
              </p>
            )}
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
              className="mt-4 w-full bg-orange-600 hover:bg-orange-700 disabled:bg-gray-400 text-white font-semibold py-3 px-6 rounded-lg transition-colors"
            >
              {submitting ? 'Submitting...' : 'Submit Query'}
            </button>
            <p className="text-sm text-gray-600 mt-2">
              Sends a query back to the rep for clarification
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
