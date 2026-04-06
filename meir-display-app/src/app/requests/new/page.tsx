'use client';

import { useState, useEffect } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';

interface Product {
  sku_code: string;
  sku_name: string;
}

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
  clientDiscountPercentage: number | '';
  boardCost: number | '';
  labourCost: number | '';
  salesForecast12Month: number | '';
  repHoursPerMonth: number | '';
  freeSamples: number | '';
  gifts: number | '';
  cataloguesPerYear: number | '';
  comments: string;
  skus: SKURow[];
}

const NUMERIC_FIELDS = [
  'rebatePercentage',
  'clientDiscountPercentage',
  'boardCost',
  'labourCost',
  'salesForecast12Month',
  'repHoursPerMonth',
  'freeSamples',
  'gifts',
  'cataloguesPerYear',
];

export default function NewRequestPage() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const draftId = searchParams.get('draft');
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);
  const [draftSaved, setDraftSaved] = useState(false);
  const [currentUser, setCurrentUser] = useState<string>('');
  const [currentDraftId, setCurrentDraftId] = useState<string | null>(draftId);
  const [products, setProducts] = useState<Product[]>([]);

  const [formData, setFormData] = useState<FormData>({
    storeName: '',
    storeCode: '',
    salesRep: '',
    brandTier: '',
    displayType: '',
    displayReason: '',
    rebatePercentage: '',
    clientDiscountPercentage: '',
    boardCost: '',
    labourCost: '',
    salesForecast12Month: '',
    repHoursPerMonth: '',
    freeSamples: '',
    gifts: '',
    cataloguesPerYear: '',
    comments: '',
    skus: [{ id: '1', code: '', name: '' }],
  });

  useEffect(() => {
    const init = async () => {
      const supabase = createClient();

      // Fetch current user
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

      // Fetch product list for SKU dropdown
      try {
        const res = await fetch('/api/products');
        if (res.ok) {
          const json = await res.json();
          setProducts(json.data || []);
        }
      } catch (err) {
        console.warn('Could not load products list:', err);
      }

      // Load existing draft if editing
      if (draftId) {
        try {
          const res = await fetch(`/api/requests/${draftId}`);
          if (res.ok) {
            const draft = await res.json();
            if (draft.status === 'draft') {
              setFormData({
                storeName: draft.store_name || '',
                storeCode: draft.store_code || '',
                salesRep: draft.rep_name || user?.email || '',
                brandTier: draft.brand_tier || '',
                displayType: draft.display_type || '',
                displayReason: draft.display_reason || '',
                rebatePercentage: draft.rebate_pct ? draft.rebate_pct * 100 : '',
                clientDiscountPercentage: draft.cogs_pct ? draft.cogs_pct * 100 : '',
                boardCost: draft.board_labour_cost || '',
                labourCost: '',
                salesForecast12Month: draft.forecast_revenue || '',
                repHoursPerMonth: draft.rep_hours_monthly || '',
                freeSamples: draft.free_samples_cost || '',
                gifts: '',
                cataloguesPerYear: draft.catalogues_qty || '',
                comments: draft.comments || '',
                skus: draft.display_skus && draft.display_skus.length > 0
                  ? draft.display_skus.map((s: { id: string; sku_code: string; sku_name: string }, i: number) => ({
                      id: String(i + 1),
                      code: s.sku_code,
                      name: s.sku_name,
                    }))
                  : [{ id: '1', code: '', name: '' }],
              });
              setCurrentDraftId(draftId);
            }
          }
        } catch {
          console.warn('Could not load draft');
        }
      }

      setLoading(false);
    };

    init();
  }, [draftId]);

  const handleInputChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>
  ) => {
    const { name, value } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: NUMERIC_FIELDS.includes(name)
        ? value === ''
          ? ''
          : parseFloat(value)
        : value,
    }));
  };

  const handleSkuChange = (index: number, selectedCode: string) => {
    const newSkus = [...formData.skus];
    const product = products.find((p) => p.sku_code === selectedCode);
    newSkus[index] = {
      ...newSkus[index],
      code: selectedCode,
      name: product?.sku_name || '',
    };
    setFormData((prev) => ({
      ...prev,
      skus: newSkus,
    }));
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
      setError('All SKUs must have a product selected');
      return false;
    }

    return true;
  };

  function buildPayload() {
    const boardLabourCost =
      (formData.boardCost === '' ? 0 : formData.boardCost) +
      (formData.labourCost === '' ? 0 : formData.labourCost);

    const freeSamplesCost =
      (formData.freeSamples === '' ? 0 : formData.freeSamples) +
      (formData.gifts === '' ? 0 : formData.gifts);

    return {
      store_name: formData.storeName,
      store_code: formData.storeCode,
      rep_name: formData.salesRep,
      brand_tier: formData.brandTier,
      display_type: formData.displayType,
      display_reason: formData.displayReason,
      rebate_pct: formData.rebatePercentage === '' ? 0 : formData.rebatePercentage,
      cogs_pct: formData.clientDiscountPercentage === '' ? 0 : formData.clientDiscountPercentage,
      board_labour_cost: boardLabourCost,
      forecast_revenue: formData.salesForecast12Month === '' ? 0 : formData.salesForecast12Month,
      rep_hours_monthly: formData.repHoursPerMonth === '' ? 0 : formData.repHoursPerMonth,
      free_samples_cost: freeSamplesCost,
      catalogues_qty: formData.cataloguesPerYear === '' ? 0 : formData.cataloguesPerYear,
      product_cogs: 0,
      photos_link: '',
      comments: formData.comments,
      skus: formData.skus.map((sku) => ({
        code: sku.code,
        name: sku.name,
      })),
    };
  }

  const handleSaveDraft = async () => {
    setSaving(true);
    setError(null);
    setDraftSaved(false);

    try {
      const payload = {
        ...buildPayload(),
        save_as: 'draft' as const,
        ...(currentDraftId ? { id: currentDraftId } : {}),
      };

      const response = await fetch('/api/requests', {
        method: currentDraftId ? 'PUT' : 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || 'Failed to save draft');
      }

      const data = await response.json();
      setCurrentDraftId(data.id);
      setDraftSaved(true);
      setTimeout(() => setDraftSaved(false), 3000);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to save draft');
    } finally {
      setSaving(false);
    }
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
        ...buildPayload(),
        save_as: 'submit' as const,
        ...(currentDraftId ? { id: currentDraftId } : {}),
      };

      const response = await fetch('/api/requests', {
        method: currentDraftId ? 'PUT' : 'POST',
        headers: { 'Content-Type': 'application/json' },
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
          <h1 className="text-3xl font-bold text-gray-900">
            {currentDraftId ? 'Edit Draft' : 'New Display Request'}
          </h1>
          <p className="mt-2 text-gray-600">
            {currentDraftId
              ? 'Continue working on your draft. Save at any time or submit when ready.'
              : 'Complete the form below to submit a new display request'}
          </p>
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
                <label className="block text-sm font-medium text-gray-700 mb-2">Client Discount %</label>
                <input
                  type="number"
                  name="clientDiscountPercentage"
                  value={formData.clientDiscountPercentage}
                  onChange={handleInputChange}
                  min="0"
                  max="100"
                  step="0.1"
                  className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  placeholder="0"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Board Cost $</label>
                <input
                  type="number"
                  name="boardCost"
                  value={formData.boardCost}
                  onChange={handleInputChange}
                  min="0"
                  step="0.01"
                  className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  placeholder="0.00"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Labour Cost $</label>
                <input
                  type="number"
                  name="labourCost"
                  value={formData.labourCost}
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
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Amount of hours you will spend with this client each month
                </label>
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
                <label className="block text-sm font-medium text-gray-700 mb-2">Free Samples $</label>
                <input
                  type="number"
                  name="freeSamples"
                  value={formData.freeSamples}
                  onChange={handleInputChange}
                  min="0"
                  step="0.01"
                  className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  placeholder="0.00"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Gifts $</label>
                <input
                  type="number"
                  name="gifts"
                  value={formData.gifts}
                  onChange={handleInputChange}
                  min="0"
                  step="0.01"
                  className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  placeholder="0.00"
                />
                <p className="mt-1 text-xs text-gray-500">
                  Enter all estimated costs for the next 12 months including buying lunch, wine, store gifts, or any other expense
                </p>
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
            </div>
          </div>

          {/* SKUs Section */}
          <div className="rounded-lg bg-white p-6 shadow">
            <h2 className="mb-6 text-xl font-semibold text-gray-900">
              SKUs <span className="text-red-500">*</span>
            </h2>

            {products.length === 0 && (
              <div className="mb-4 rounded bg-yellow-50 border border-yellow-200 p-3 text-sm text-yellow-800">
                Product list is not yet configured. Please contact your administrator.
              </div>
            )}

            <div className="space-y-4">
              {formData.skus.map((sku, index) => (
                <div key={sku.id} className="flex gap-4 items-end">
                  <div className="flex-1">
                    <label className="block text-sm font-medium text-gray-700 mb-2">SKU Code</label>
                    {products.length > 0 ? (
                      <select
                        value={sku.code}
                        onChange={(e) => handleSkuChange(index, e.target.value)}
                        className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                        required
                      >
                        <option value="">Select a product</option>
                        {products.map((product) => (
                          <option key={product.sku_code} value={product.sku_code}>
                            {product.sku_code}
                          </option>
                        ))}
                      </select>
                    ) : (
                      <input
                        type="text"
                        value={sku.code}
                        onChange={(e) => {
                          const newSkus = [...formData.skus];
                          newSkus[index] = { ...newSkus[index], code: e.target.value };
                          setFormData((prev) => ({ ...prev, skus: newSkus }));
                        }}
                        className="w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                        placeholder="Enter SKU code"
                        required
                      />
                    )}
                  </div>

                  <div className="flex-1">
                    <label className="block text-sm font-medium text-gray-700 mb-2">SKU Name</label>
                    <input
                      type="text"
                      value={sku.name}
                      readOnly
                      className="w-full rounded border border-gray-200 bg-gray-50 px-3 py-2 text-gray-700"
                      placeholder={products.length > 0 ? 'Auto filled from selection' : 'Enter SKU name'}
                    />
                  </div>

                  <div>
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

          {/* Action Buttons */}
          <div className="space-y-3">
            {draftSaved && (
              <div className="rounded-lg bg-green-50 p-3 text-green-700 border border-green-200 text-sm text-center">
                Draft saved successfully
              </div>
            )}
            <div className="flex gap-4">
              <button
                type="submit"
                disabled={submitting || saving}
                className="flex-1 rounded bg-blue-600 px-6 py-3 text-white font-medium hover:bg-blue-700 disabled:bg-gray-400 disabled:cursor-not-allowed"
              >
                {submitting ? 'Submitting...' : 'Submit Request'}
              </button>
              <button
                type="button"
                onClick={handleSaveDraft}
                disabled={saving || submitting}
                className="flex-1 rounded bg-gray-100 border border-gray-300 px-6 py-3 text-gray-700 font-medium hover:bg-gray-200 disabled:bg-gray-100 disabled:cursor-not-allowed"
              >
                {saving ? 'Saving...' : 'Save Draft'}
              </button>
            </div>
            <button
              type="button"
              onClick={() => router.back()}
              className="w-full rounded bg-gray-50 px-6 py-2 text-gray-500 font-medium hover:bg-gray-100 text-sm"
            >
              Cancel
            </button>
          </div>
        </form>
      </div>
    </main>
  );
}
