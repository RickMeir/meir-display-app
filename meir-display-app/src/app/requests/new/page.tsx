'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';

interface SKURow {
  id: string;
  code: string;
  name: string;
}

interface FormData {
  storeName: string;
  storeCode: string;
  salesRep: string;
  brandTier: string;
  displayType: string;
  displayReason: string;
  rebatePercentage: number | '';
  cogsDiscountPercentage: number | '';
  boardAndLabourCost: number | '';
  salesForecast12Month: number | '';
  repHoursPerMonth: number | '';
  freeSamplesAndGifts: number | '';
  cataloguesPerYear: number | '';
  displayProductCogs: number | '';
  photosLink: string;
  comments: string;
  skus: SKURow[];
}

export default function NewRequestPage() {
  const router = useRouter();
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);
  const [currentUser, setCurrentUser] = useState<string>('');

  const [formData, setFormData] = useState<FormData>({
    storeName: '',
    storeCode: '',
    salesRep: '',
    brandTier: '',
    displayType: '',
    displayReason: '',
    rebatePercentage: '',
    cogsDiscountPercentage: '',
    boardAndLabourCost: '',
    salesForecast12Month: '',
    repHoursPerMonth: '',
    freeSamplesAndGifts: '',
    cataloguesPerYear: '',
    displayProductCogs: '',
    photosLink: '',
    comments: '',
    skus: [{ id: '1', code: '', name: '' }],
  });

  useEffect(() => {
    const fetchUser = async () => {
      const supabase = createClient();
      const {
        data: { user },
      } = await supabase.auth.getUser();

      if (user?.email) {
        setCurrentUser(user.email);
        setFormData((prev) => ({
          ...prev,
          salesRep: user.email!,
        }));
      }

      setLoading(false);
    };

    fetchUser();
  }, []);

  const handleInputChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>,
    index?: number
  ) => {
    const { name, value } = e.target;

    if (name.startsWith('sku')) {
      const skuIndex = index ?? 0;
      const field = name.replace(`sku${skuIndex}`, '');
      const newSkus = [...formData.skus];
      newSkus[skuIndex] = {
        ...newSkus[skuIndex],
        [field]: value,
      };
      setFormData((prev) => ({
        ...prev,
        skus: newSkus,
      }));
    } else {
      setFormData((prev) => ({
        ...prev,
        [name]: name.includes('Percentage') || name.includes('Cost') || name.includes('Forecast') || name.includes('Hours') || name.includes('Gifts') || name.includes('Year') || name.includes('Cogs')
          ? value === ''
            ? ''
            : parseFloat(value)
          : value,
      }));
    }
  };

  const addSKU = () => {
    const newId = Math.max(0, ...formData.skus.map((s) => parseInt(s.id))) + 1;
    setFormData((prev) => ({
      ...prev,
      skus: [...prev.skus, { id: newId.toString(), code: '', name: '' }],
    }));
  };

  const removeSKU = (id: string) => {
    if (formData.skus.length > 1) {
      setFormData((prev) => ({
        ...prev,
        skus: prev.skus.filter((sku) => sku.id !== id),
      }));
    }
  };

  const validateForm = (): boolean => {
    if (!formData.storeName.trim()) {
      setError('Store Name is required');
      return false;
    }
    if (!formData.storeCode.trim()) {
      setError('Store Code is required');
      return false;
    }
    if (!formData.salesRep.trim()) {
      setError('Sales Rep is required');
      return false;
    }
    if (!formData.brandTier) {
      setError('Brand Tier is required');
      return false;
    }
    if (!formData.displayType) {
      setError('Display Type is required');
      return false;
    }
    if (formData.salesForecast12Month === '' || formData.salesForecast12Month === null) {
      setError('12 Month Sales Forecast is required');
      return false;
    }
    if (formData.skus.length === 0) {
      setError('At least one SKU is required');
      return false;
    }
    const validSkus = formData.skus.every((sku) => sku.code.trim() && sku.name.trim());
    if (!validSkus) {
      setError('All SKUs must have both code and name');
      return false;
    }

    return true;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);

    if (!validateForm()) {
      return;
    }

    setSubmitting(true);

    try {
      const payload = {
        store_name: formData.storeName,
        store_code: formData.storeCode,
        rep_name: formData.salesRep,
        brand_tier: formData.brandTier,
        display_type: formData.displayType,
        display_reason: formData.displayReason,
        rebate_pct: formData.rebatePercentage === '' ? 0 : formData.rebatePercentage,
        cogs_pct: formData.cogsDiscountPercentage === '' ? 0 : formData.cogsDiscountPercentage,
        board_labour_cost: formData.boardAndLabourCost === '' ? 0 : formData.boardAndLabourCost,
        forecast_revenue: formData.salesForecast12Month === '' ? 0 : formData.salesForecast12Month,
        rep_hours_monthly: formData.repHoursPerMonth === '' ? 0 : formData.repHoursPerMonth,
        free_samples_cost: formData.freeSamplesAndGifts === '' ? 0 : formData.freeSamplesAndGifts,
        catalogues_qty: formData.cataloguesPerYear === '' ? 0 : formData.cataloguesPerYear,
        product_cogs: formData.displayProductCogs === '' ? 0 : formData.displayProductCogs,
        photos_link: formData.photosLink,
        comments: formData.comments,
        skus: formData.skus.map((sku) => ({
          code: sku.code,
          name: sku.name,
        })),
      };

      const response = await fetch('/api/requests', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload),
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || 'Failed to submit request');
      }

      setSuccess(true);
      setTimeout(() => {
        router.push('/requests?success=true');
      }, 500);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred whilst submitting the form');
      setSubmitting(false);
    }
  };

  if (loading) {
    return (
      <main className="min-h-screen bg-gray-50 py-8">
        <div className="mx-auto max-w-4xl px-4">
          <div className="animate-pulse">
            <div className="mb-8 h-10 w-48 rounded bg-gray-200"></div>
            <div className="space-y-4">
              <div className="h-64 rounded-lg bg-gray-200"></div>
            </div>
          </div>
        </div>
      </main>
    );
  }

  return (
    <main className="min-h-screen bg-gray-50 py-8">
      <div className="mx-auto max-w-4xl px-4">
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-gray-900">New Display Request</h1>
          <p className="mt-2 text-gray-600">Complete the form below to submit a new display request</p>
        </div>

        {error && (
          <div className="mb-6 rounded-lg bg-red-50 p-4 text-red-700 border border-red-200">
            <p className="font-medium">Error</p>
            <p className="text-sm">{error}</p>
          </div>
        )}

        {success && (
          <div className="mb-6 rounded-lg bg-green-50 p-4 text-green-700 border border-green-200">
            <p className="font-medium">Success</p>
            <p className="text-sm">Your display request has been submitted successfully</p>
          </div>
        )}

        <form onSubmit={handleSubmit} className="space-y-8">
          {/* Store Details Section */}
          <div className="rounded-lg bg-white p-6 shadow">
            <h2 className="mb-6 text-xl font-semibold text-gray-900">Store Details</h2>

            <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Store Name <span className="text-red-500">*</span>
                </label>
                <input
                  type="text"
                  name="storeName"
                  value={formData.storeName}
                  onChange={handleInputChange}
                  className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  placeholder="Enter store name"
                  required
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Store Code <span className="text-red-500">*</span>
                </label>
                <input
                  type="text"
                  name="storeCode"
                  value={formData.storeCode}
                  onChange={handleInputChange}
                  className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  placeholder="Enter store code"
                  required
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Sales Rep <span className="text-red-500">*</span>
                </label>
                <input
                  type="text"
                  name="salesRep"
                  value={formData.salesRep}
                  onChange={handleInputChange}
                  className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  placeholder="Enter sales rep name or email"
                  required
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Brand Tier <span className="text-red-500">*</span>
                </label>
                <select
                  name="brandTier"
                  value={formData.brandTier}
                  onChange={handleInputChange}
                  className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  required
                >
                  <option value="">Select brand tier</option>
                  <option value="Premium">Premium</option>
                  <option value="Mid-Range">Mid Range</option>
                  <option value="Value">Value</option>
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Display Type <span className="text-red-500">*</span>
                </label>
                <select
                  name="displayType"
                  value={formData.displayType}
                  onChange={handleInputChange}
                  className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  required
                >
                  <option value="">Select display type</option>
                  <option value="Freestanding">Freestanding</option>
                  <option value="Shelf">Shelf</option>
                  <option value="Counter">Counter</option>
                  <option value="Wall">Wall</option>
                  <option value="End Cap">End Cap</option>
                  <option value="Other">Other</option>
                </select>
              </div>
            </div>

            <div className="mt-6">
              <label className="block text-sm font-medium text-gray-700 mb-2">Display Reason</label>
              <textarea
                name="displayReason"
                value={formData.displayReason}
                onChange={handleInputChange}
                rows={3}
                className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                placeholder="Explain why this display is needed"
              ></textarea>
            </div>
          </div>

          {/* Financial Details Section */}
          <div className="rounded-lg bg-white p-6 shadow">
            <h2 className="mb-6 text-xl font-semibold text-gray-900">Financial Details</h2>

            <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Rebate %</label>
                <input
                  type="number"
                  name="rebatePercentage"
                  value={formData.rebatePercentage}
                  onChange={handleInputChange}
                  min="0"
                  max="100"
                  step="0.1"
                  className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  placeholder="0"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">COGS / Discount %</label>
                <input
                  type="number"
                  name="cogsDiscountPercentage"
                  value={formData.cogsDiscountPercentage}
                  onChange={handleInputChange}
                  min="0"
                  max="100"
                  step="0.1"
                  className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  placeholder="0"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Board and Labour Cost $</label>
                <input
                  type="number"
                  name="boardAndLabourCost"
                  value={formData.boardAndLabourCost}
                  onChange={handleInputChange}
                  min="0"
                  step="0.01"
                  className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  placeholder="0.00"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  12 Month Sales Forecast $ <span className="text-red-500">*</span>
                </label>
                <input
                  type="number"
                  name="salesForecast12Month"
                  value={formData.salesForecast12Month}
                  onChange={handleInputChange}
                  min="0"
                  step="0.01"
                  className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  placeholder="0.00"
                  required
                />
                <p className="mt-1 text-xs text-gray-500">This value cannot be changed after submission</p>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Rep Hours per Month</label>
                <input
                  type="number"
                  name="repHoursPerMonth"
                  value={formData.repHoursPerMonth}
                  onChange={handleInputChange}
                  min="0"
                  step="0.5"
                  className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  placeholder="0"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Free Samples and Gifts $</label>
                <input
                  type="number"
                  name="freeSamplesAndGifts"
                  value={formData.freeSamplesAndGifts}
                  onChange={handleInputChange}
                  min="0"
                  step="0.01"
                  className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  placeholder="0.00"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Catalogues per Year</label>
                <input
                  type="number"
                  name="cataloguesPerYear"
                  value={formData.cataloguesPerYear}
                  onChange={handleInputChange}
                  min="0"
                  className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  placeholder="0"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Display Product COGS $</label>
                <input
                  type="number"
                  name="displayProductCogs"
                  value={formData.displayProductCogs}
                  onChange={handleInputChange}
                  min="0"
                  step="0.01"
                  className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  placeholder="0.00"
                />
              </div>
            </div>
          </div>

          {/* SKUs Section */}
          <div className="rounded-lg bg-white p-6 shadow">
            <h2 className="mb-6 text-xl font-semibold text-gray-900">
              SKUs <span className="text-red-500">*</span>
            </h2>

            <div className="space-y-4">
              {formData.skus.map((sku, index) => (
                <div key={sku.id} className="flex gap-4">
                  <div className="flex-1">
                    <label className="block text-sm font-medium text-gray-700 mb-2">SKU Code</label>
                    <input
                      type="text"
                      name={`skuCode${index}`}
                      value={sku.code}
                      onChange={(e) => handleInputChange(e, index)}
                      className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                      placeholder="Enter SKU code"
                      required
                    />
                  </div>

                  <div className="flex-1">
                    <label className="block text-sm font-medium text-gray-700 mb-2">SKU Name</label>
                    <input
                      type="text"
                      name={`skuName${index}`}
                      value={sku.name}
                      onChange={(e) => handleInputChange(e, index)}
                      className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                      placeholder="Enter SKU name"
                      required
                    />
                  </div>

                  <div className="flex items-end">
                    <button
                      type="button"
                      onClick={() => removeSKU(sku.id)}
                      disabled={formData.skus.length === 1}
                      className="rounded bg-red-50 px-4 py-2 text-red-600 hover:bg-red-100 disabled:opacity-50 disabled:cursor-not-allowed font-medium text-sm"
                    >
                      Remove
                    </button>
                  </div>
                </div>
              ))}
            </div>

            <button
              type="button"
              onClick={addSKU}
              className="mt-6 rounded bg-blue-50 px-4 py-2 text-blue-600 hover:bg-blue-100 font-medium text-sm"
            >
              Add SKU
            </button>
          </div>

          {/* Additional Section */}
          <div className="rounded-lg bg-white p-6 shadow">
            <h2 className="mb-6 text-xl font-semibold text-gray-900">Additional</h2>

            <div className="space-y-6">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Photos Link</label>
                <input
                  type="url"
                  name="photosLink"
                  value={formData.photosLink}
                  onChange={handleInputChange}
                  className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  placeholder="https://example.com/photos"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Comments</label>
                <textarea
                  name="comments"
                  value={formData.comments}
                  onChange={handleInputChange}
                  rows={4}
                  className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  placeholder="Add any additional comments or notes"
                ></textarea>
              </div>
            </div>
          </div>

          {/* Submit Button */}
          <div className="flex gap-4">
            <button
              type="submit"
              disabled={submitting}
              className="flex-1 rounded bg-blue-600 px-6 py-3 text-white font-medium hover:bg-blue-700 disabled:bg-gray-400 disabled:cursor-not-allowed"
            >
              {submitting ? 'Submitting...' : 'Submit Request'}
            </button>
            <button
              type="button"
              onClick={() => router.back()}
              className="flex-1 rounded bg-gray-200 px-6 py-3 text-gray-900 font-medium hover:bg-gray-300"
            >
              Cancel
            </button>
          </div>
        </form>
      </div>
    </main>
  );
}
