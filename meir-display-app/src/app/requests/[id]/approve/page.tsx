'use client';

import { useParams, useRouter } from 'next/navigation';
import { useEffect, useState } from 'react';
import { createClient } from '@/lib/supabase/client';
import { formatCurrency } from '@/lib/calculations';
import { STATUS_LABELS, STATUS_COLOURS } from '@/lib/types';

interface Request {
  id: string;
  status: string;
  store_name: string;
  store_code: string;
  rep_name: string;
  brand_tier: string;
  display_type: string;
  total_investment: number;
  forecast_revenue: number;
  net_contribution: number;
  approval_tier: string;
  profitability_flag: string;
  skus: Array<{
    id: string;
    code: string;
    name: string;
  }>;
}

export default function ApprovePage() {
  const params = useParams();
  const router = useRouter();
  const requestId = params.id as string;

  const [request, setRequest] = useState<Request | null>(null);
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
      <div className="flex items-center justify-center min-h-screen bg-gray-50">
        <p className="text-gray-600">Loading request details...</p>
      </div>
    );
  }

  if (error && !request) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-gray-50">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-gray-900 mb-4">Error</h1>
          <p className="text-gray-600">{error}</p>
        </div>
      </div>
    );
  }

  if (!request) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-gray-50">
        <p className="text-gray-600">Request not found</p>
      </div>
    );
  }

  if (request.status !== 'pending_approval') {
    return (
      <div className="flex items-center justify-center min-h-screen bg-gray-50">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-gray-900 mb-4">Already Processed</h1>
          <p className="text-gray-600">This request has already been processed and cannot be approved.</p>
        </div>
      </div>
    );
  }

  const netMarginPercent = request.forecast_revenue > 0
    ? ((request.net_contribution / request.forecast_revenue) * 100).toFixed(1)
    : '0.0';

  const showProfitabilityWarning = request.profitability_flag === 'REVIEW';

  return (
    <div className="min-h-screen bg-gray-50 p-8">
      <div className="max-w-4xl mx-auto">
        <h1 className="text-4xl font-bold text-gray-900 mb-8">Approve Display Request</h1>

        {error && (
          <div className="mb-8 p-4 bg-red-50 border border-red-200 rounded-lg">
            <p className="text-red-700">{error}</p>
          </div>
        )}

        <div className="bg-white rounded-lg shadow-md p-8 mb-8">
          <h2 className="text-2xl font-semibold text-gray-900 mb-6">Store Details</h2>
          <div className="grid grid-cols-2 gap-6 mb-8">
            <div>
              <p className="text-sm text-gray-600 mb-1">Store Name</p>
              <p className="text-lg font-medium text-gray-900">{request.store_name}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600 mb-1">Store Code</p>
              <p className="text-lg font-medium text-gray-900">{request.store_code}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600 mb-1">Sales Representative</p>
              <p className="text-lg font-medium text-gray-900">{request.rep_name}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600 mb-1">Brand Tier</p>
              <p className="text-lg font-medium text-gray-900">{request.brand_tier}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600 mb-1">Display Type</p>
              <p className="text-lg font-medium text-gray-900">{request.display_type}</p>
            </div>
            <div>
              <p className="text-sm text-gray-600 mb-1">Approval Tier</p>
              <p className="text-lg font-medium text-gray-900">{request.approval_tier}</p>
            </div>
          </div>
        </div>

        <div className="bg-white rounded-lg shadow-md p-8 mb-8">
          <h2 className="text-2xl font-semibold text-gray-900 mb-6">Financial Summary</h2>
          <div className="grid grid-cols-2 gap-6 mb-8">
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
              <p className="text-2xl font-bold text-gray-900">{formatCurrency(request.net_contribution)}</p>
            </div>
            <div className="p-4 bg-gray-50 rounded-lg">
              <p className="text-sm text-gray-600 mb-2">Net Margin Percentage</p>
              <p className="text-2xl font-bold text-gray-900">{netMarginPercent}%</p>
            </div>
          </div>

          {showProfitabilityWarning && (
            <div className="mb-6 p-4 bg-yellow-50 border-l-4 border-yellow-400 rounded">
              <p className="text-yellow-800 font-medium">
                This request is below profitability thresholds. Consider carefully.
              </p>
            </div>
          )}
        </div>

        <div className="bg-white rounded-lg shadow-md p-8 mb-8">
          <h2 className="text-2xl font-semibold text-gray-900 mb-6">SKUs</h2>
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead>
                <tr className="border-b border-gray-200">
                  <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">SKU Code</th>
                  <th className="text-left py-3 px-4 text-sm font-semibold text-gray-700">SKU Name</th>
                </tr>
              </thead>
              <tbody>
                {request.skus.map((sku, index) => (
                  <tr key={sku.id} className={index % 2 === 0 ? 'bg-white' : 'bg-gray-50'}>
                    <td className="py-3 px-4 text-sm text-gray-900">{sku.code}</td>
                    <td className="py-3 px-4 text-sm text-gray-900">{sku.name}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

        <div className="bg-white rounded-lg shadow-md p-8 mb-8">
          <h2 className="text-2xl font-semibold text-gray-900 mb-6">Decision Notes</h2>
          <textarea
            value={note}
            onChange={(e) => setNote(e.target.value)}
            placeholder="Add optional notes for approval or required notes for rejection"
            className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 resize-none"
            rows={6}
          />
          <p className="text-xs text-gray-500 mt-2">
            Note: Rejection requires a mandatory note explaining the decision.
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
    </div>
  );
}
