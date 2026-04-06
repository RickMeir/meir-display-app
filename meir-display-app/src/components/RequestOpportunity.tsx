'use client';

import { DisplayRequest } from '@/lib/types';
import { formatCurrency } from '@/lib/calculations';

interface Photo {
  id: string;
  photo_url: string;
  photo_type: string;
  filename: string;
}

interface RequestOpportunityProps {
  request: DisplayRequest & { request_photos?: Photo[] };
}

const PHOTO_TYPE_LABELS: Record<string, string> = {
  location: 'Display Location',
  design_rendering: 'Design Rendering',
  current_display: 'Current Display',
};

export default function RequestOpportunity({ request }: RequestOpportunityProps) {
  const photos = request.request_photos || [];
  const locationPhotos = photos.filter((p) => p.photo_type === 'location');
  const renderingPhotos = photos.filter((p) => p.photo_type === 'design_rendering');
  const currentPhotos = photos.filter((p) => p.photo_type === 'current_display');

  return (
    <>
      {/* Opportunity */}
      <div className="bg-gray-300 rounded-lg shadow p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Opportunity</h2>
        <div className="space-y-4 text-sm">
          {request.opportunity_description && (
            <div>
              <p className="text-gray-500 mb-1">Why should we invest in this display?</p>
              <p className="text-gray-900 whitespace-pre-wrap">{request.opportunity_description}</p>
            </div>
          )}
          {request.competitor_brands && (
            <div>
              <p className="text-gray-500 mb-1">Closest competitor brands</p>
              <p className="text-gray-900">{request.competitor_brands}</p>
            </div>
          )}
          {request.differentiation_plan && (
            <div>
              <p className="text-gray-500 mb-1">How will this display stand out?</p>
              <p className="text-gray-900 whitespace-pre-wrap">{request.differentiation_plan}</p>
            </div>
          )}
          <div className="grid grid-cols-2 gap-4">
            {request.is_new_or_replacement && (
              <div>
                <p className="text-gray-500 mb-1">New or replacement</p>
                <p className="font-medium text-gray-900 capitalize">{request.is_new_or_replacement}</p>
              </div>
            )}
            {request.planned_install_date && (
              <div>
                <p className="text-gray-500 mb-1">Planned install date</p>
                <p className="font-medium text-gray-900">
                  {new Date(request.planned_install_date).toLocaleDateString('en-AU')}
                </p>
              </div>
            )}
            <div>
              <p className="text-gray-500 mb-1">Store agreed to location</p>
              <p className={`font-medium ${request.store_agreed_location ? 'text-green-700' : 'text-red-600'}`}>
                {request.store_agreed_location ? 'Yes' : 'No'}
              </p>
            </div>
          </div>
        </div>
      </div>

      {/* Initial Order Commitment */}
      <div className="bg-gray-300 rounded-lg shadow p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Initial Order Commitment</h2>
        {request.has_initial_order ? (
          <div className="space-y-3 text-sm">
            <div className="flex items-center gap-2">
              <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                Yes — commitment secured
              </span>
            </div>
            {(request.initial_order_value !== undefined && request.initial_order_value > 0) && (
              <div>
                <p className="text-gray-500 mb-1">Order value</p>
                <p className="text-lg font-semibold text-gray-900">{formatCurrency(request.initial_order_value)}</p>
              </div>
            )}
            {request.initial_order_notes && (
              <div>
                <p className="text-gray-500 mb-1">Details</p>
                <p className="text-gray-900 whitespace-pre-wrap">{request.initial_order_notes}</p>
              </div>
            )}
          </div>
        ) : (
          <div className="space-y-3 text-sm">
            <div className="flex items-center gap-2">
              <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
                No — no initial order
              </span>
            </div>
            {request.initial_order_notes && (
              <div>
                <p className="text-gray-500 mb-1">Reason</p>
                <p className="text-gray-900 whitespace-pre-wrap">{request.initial_order_notes}</p>
              </div>
            )}
          </div>
        )}
      </div>

      {/* Photos */}
      {photos.length > 0 && (
        <div className="bg-gray-300 rounded-lg shadow p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Photos</h2>
          <div className="space-y-6">
            {[
              { label: 'Display Location', items: locationPhotos },
              { label: 'Design Rendering', items: renderingPhotos },
              { label: 'Current Display', items: currentPhotos },
            ]
              .filter((group) => group.items.length > 0)
              .map((group) => (
                <div key={group.label}>
                  <p className="text-sm font-medium text-gray-600 mb-2">{group.label}</p>
                  <div className="grid grid-cols-2 sm:grid-cols-3 gap-3">
                    {group.items.map((photo) => (
                      <a
                        key={photo.id}
                        href={photo.photo_url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="block aspect-square rounded-lg overflow-hidden border border-gray-200 hover:border-blue-400 transition-colors"
                      >
                        <img
                          src={photo.photo_url}
                          alt={photo.filename}
                          className="w-full h-full object-cover"
                        />
                      </a>
                    ))}
                  </div>
                </div>
              ))}
          </div>
        </div>
      )}
    </>
  );
}
