'use client';

import { useParams, useRouter } from 'next/navigation';
import { useEffect, useState } from 'react';
import Link from 'next/link';
import { formatCurrency, formatPercent } from '@/lib/calculations';
import { DisplayRequest, STATUS_LABELS } from '@/lib/types';
import RequestOpportunity from '@/components/RequestOpportunity';

export default function ApprovePage() {
  const params = useParams();
  const router = useRouter();
  const requestId = params.id as string;

  const [request, setRequest] = useState<DisplayRequest | null>(null);
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [note, setNote] = useState('');

  useEffect(() => {
    const fetchRequest = async () => {
      try {
        const response = await fetch(`/api/requests/${requestId}`);
        if (!response.ok) {
          throw new Error('Failed to fetch request');
        }
        const data = await response.json();
        setRequest(data);

        if (data.status !== 'pending_approval') {
          setError('This request has already been processed.');
        }
      } catch (err) {
        setError(err instanceof Error ? err.message : 'An error occurred');
      } finally {
        setLoading(false);
      }
    };

    fetchRequest();
  }, [requestId]);

  const handleApprove = async () => {
    setSubmitting(true);
    try {
      const response = await fetch(`/api/requests/${requestId}/approve`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ action: 'approve', note }),
      });

      if (!response.ok) {
        throw new Error('Failed to approve request');
      }

      router.push('/dashboard');
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    } finally {
      setSubmitting(false);
    }
  };

  const handleReject = async () => {
    if (!note.trim()) {
      setError('A note is required when rejecting');
      return;
    }

    setSubmitting(true);
    try {
      const response = await fetch(`/api/requests/${requestId}/approve`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ action: 'reject', note }),
      });

      if (!response.ok) {
        throw new Error('Failed to reject request');
      }

      router.push('/dashboard');
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    } finally {
      setSubmitting(false);
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center py-12">
        <p className="text-gray-600">Loading request details...</p>
      </div>
    );
  }

  if (error && !request) {
    return (
      <div className="max-w-4xl mx-auto py-8">
        <div className="bg-gray-400 rounded-lg shadow p-8 text-center">
          <h1 className="text-2xl font-bold text-gray-900 mb-4">Error</h1>
          <p className="text-gray-600">{error}</p>
        </div>
      </div>
    );
  }

  if (!request) {
    return (
      <div className="max-w-4xl mx-auto py-8">
        <p className="text-gray-600 text-center">Request not found</p>
      </div>
    );
  }

  if (request.status !== 'pending_approval') {
    return (
      <div className="max-w-4xl mx-auto py-8">
        <div className="bg-gray-400 rounded-lg shadow p-8 text-center">
          <h1 className="text-2xl font-bold text-gray-900 mb-4">Already Processed</h1>
          <p className="text-gray-600">
            This request has a status of &quot;{STATUS_LABELS[request.status]}&quot; and cannot be approved.
          </p>
        </div>
      </div>
    );
  }

  const showProfitabilityWarning = request.profitability_flag === 'review';

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <h1 className="text-3xl font-bold text-gray-900">Approve Display Request</h1>

      {error && (
        <div className="p-4 bg-red-50 border border-red-200 rounded-lg">
          <p className="text-red-700">{error}</p>
        </div>
      )}

      {/* Store Details */}
      <div className="bg-gray-400 rounded-lg shadow p-6">
        <h2 className="text-xl font-semibold text-gray-900 mb-6">Store Details</h2>
        <div className="grid grid-cols-2 gap-6">
          <div>
            <p className="text-sm text-gray-600 mb-1">Store Name</p>
            <p className="text-lg font-medium text-gray-900">{request.store_name}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600 mb-1">Store Code</p>
            <p className="text-lg font-medium text-gray-900">{request.store_code}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600 mb-1">Sales Rep</p>
            <p className="text-lg font-medium text-gray-900">{request.rep_name}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600 mb-1">Brand Tier</p>
            <p className="text-lg font-medium text-gray-900">{request.brand_tier || '—'}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600 mb-1">Display Type</p>
            <p className="text-lg font-medium text-gray-900">{request.display_type || '—'}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600 mb-1">Approval Tier</p>
            <p className="text-lg font-medium text-gray-900">{request.approval_tier?.toUpperCase() || '—'}</p>
          </div>
        </div>
      </div>

      {/* Opportunity, Initial Order, Photos */}
      <RequestOpportunity request={request} />

      {/* Financial Summary */}
      <div className="bg-gray-400 rounded-lg shadow p-6">
        <h2 className="text-xl font-semibold text-gray-900 mb-6">Financial Summary</h2>

        {/* Verdict + Profitability badges */}
        <div className="mb-6 flex flex-wrap gap-2">
          <span className={`inline-flex items-center px-3 py-1 rounded-full text-sm font-bold ${
            request.profitability_flag === 'green'
              ? 'bg-green-100 text-green-800'
              : 'bg-yellow-100 text-yellow-800'
          }`}>
            {request.profitability_flag === 'green' ? 'GREEN — Viable' : 'REVIEW — Below Thresholds'}
          </span>
          {request.verdict && (
            <span className={`inline-flex items-center px-3 py-1 rounded-full text-sm font-bold ${
              request.verdict === 'worth_it' ? 'bg-green-100 text-green-800' :
              request.verdict === 'marginal' ? 'bg-amber-100 text-amber-800' :
              'bg-red-100 text-red-800'
            }`}>
              {request.verdict === 'worth_it' ? 'Worth It' :
               request.verdict === 'marginal' ? 'Marginal' :
               'Not Worth It'}
              {request.roi_multiplier != null && ` (${request.roi_multiplier.toFixed(1)}x ROI)`}
            </span>
          )}
        </div>

        {/* Initial order confidence indicator */}
        {request.has_initial_order && request.initial_order_value > 0 && (
          <div className="mb-4 p-3 bg-blue-50 border border-blue-200 rounded-lg">
            <p className="text-sm text-blue-800">
              <span className="font-semibold">Initial Order Committed:</span>{' '}
              {formatCurrency(request.initial_order_value)}
              {request.forecast_revenue > 0 && (
                <span className="ml-1">
                  ({Math.round((request.initial_order_value / request.forecast_revenue) * 100)}% of forecast already secured)
                </span>
              )}
            </p>
          </div>
        )}

        {/* Existing client baseline */}
        {request.is_existing_client && request.existing_annual_revenue > 0 && (
          <div className="mb-4 p-3 bg-blue-50 border border-blue-200 rounded-lg">
            <p className="text-xs font-semibold text-blue-800 mb-2">Existing Client Baseline</p>
            <div className="grid grid-cols-3 gap-3 text-xs">
              <div>
                <p className="text-blue-600">Current Revenue</p>
                <p className="font-bold text-blue-900">{formatCurrency(request.existing_annual_revenue)}</p>
              </div>
              <div>
                <p className="text-blue-600">Baseline (+ 15% growth)</p>
                <p className="font-bold text-blue-900">{formatCurrency(request.baseline_revenue)}</p>
              </div>
              <div>
                <p className="text-blue-600">Incremental Revenue</p>
                <p className={`font-bold ${request.incremental_revenue >= 0 ? 'text-green-700' : 'text-red-600'}`}>
                  {formatCurrency(request.incremental_revenue)}
                </p>
              </div>
            </div>
          </div>
        )}

        <div className="grid grid-cols-2 gap-6 mb-6">
          <div className="p-4 bg-blue-50 rounded-lg">
            <p className="text-sm text-gray-600 mb-2">Total Investment</p>
            <p className="text-2xl font-bold text-blue-700">{formatCurrency(request.total_investment)}</p>
          </div>
          <div className="p-4 bg-green-50 rounded-lg">
            <p className="text-sm text-gray-600 mb-2">Forecast Revenue</p>
            <p className="text-2xl font-bold text-green-700">{formatCurrency(request.forecast_revenue)}</p>
          </div>
          <div className="p-4 bg-gray-50 rounded-lg">
            <p className="text-sm text-gray-600 mb-2">Net Contribution</p>
            <p className={`text-2xl font-bold ${request.net_contribution >= 2000 ? 'text-green-700' : 'text-red-600'}`}>{formatCurrency(request.net_contribution)}</p>
          </div>
          <div className="p-4 bg-gray-50 rounded-lg">
            <p className="text-sm text-gray-600 mb-2">Net Margin</p>
            <p className={`text-2xl font-bold ${request.net_margin >= 0.15 ? 'text-green-700' : 'text-red-600'}`}>{formatPercent(request.net_margin)}</p>
          </div>
          {request.roi_multiplier != null && (
            <div className="p-4 bg-gray-50 rounded-lg">
              <p className="text-sm text-gray-600 mb-2">ROI Multiplier</p>
              <p className={`text-2xl font-bold ${request.roi_multiplier >= 2 ? 'text-green-700' : request.roi_multiplier >= 1 ? 'text-amber-600' : 'text-red-600'}`}>{request.roi_multiplier.toFixed(2)}x</p>
            </div>
          )}
          <div className="p-4 bg-gray-50 rounded-lg">
            <p className="text-sm text-gray-600 mb-2">Gross Profit</p>
            <p className="text-2xl font-bold text-gray-900">{formatCurrency(request.gross_profit)}</p>
          </div>
        </div>

        {showProfitabilityWarning && (
          <div className="p-4 bg-yellow-50 border-l-4 border-yellow-400 rounded">
            <p className="text-yellow-800 font-medium">
              This request is below profitability thresholds. Approving will trigger a discrete notification to Rick and Paul.
            </p>
          </div>
        )}
      </div>

      {/* SKUs */}
      {request.skus && request.skus.length > 0 && (
        <div className="bg-gray-400 rounded-lg shadow p-6">
          <h2 className="text-xl font-semibold text-gray-900 mb-4">SKUs</h2>
          <table className="w-full">
            <thead>
              <tr className="border-b border-gray-200">
                <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">SKU Code</th>
                <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">SKU Name</th>
              </tr>
            </thead>
            <tbody>
              {request.skus.map((sku, index) => (
                <tr key={sku.id} className={index % 2 === 0 ? 'bg-gray-300' : 'bg-gray-200'}>
                  <td className="py-3 px-4 text-sm text-gray-900 font-mono">{sku.sku_code}</td>
                  <td className="py-3 px-4 text-sm text-gray-900">{sku.sku_name || '—'}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {/* Decision */}
      <div className="bg-gray-400 rounded-lg shadow p-6">
        <h2 className="text-xl font-semibold text-gray-900 mb-4">Decision Notes</h2>
        <textarea
          value={note}
          onChange={(e) => setNote(e.target.value)}
          placeholder="Add optional notes for approval or required notes for rejection"
          className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 resize-none"
          rows={4}
        />
        <p className="text-xs text-gray-500 mt-2">
          A note is required when rejecting.
        </p>
      </div>

      <div className="flex gap-4">
        <button
          onClick={handleApprove}
          disabled={submitting}
          className="flex-1 px-6 py-3 bg-green-600 text-white font-semibold rounded-lg hover:bg-green-700 disabled:bg-gray-400 disabled:cursor-not-allowed transition-colors"
        >
          {submitting ? 'Approving...' : 'Approve'}
        </button>
        <button
          onClick={handleReject}
          disabled={submitting}
          className="flex-1 px-6 py-3 bg-red-600 text-white font-semibold rounded-lg hover:bg-red-700 disabled:bg-gray-400 disabled:cursor-not-allowed transition-colors"
        >
          {submitting ? 'Rejecting...' : 'Reject'}
        </button>
      </div>
    </div>
  );
}
