'use client';

import { useState, useEffect } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';
import Image from 'next/image';

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
  opportunityDescription: string;
  competitorBrands: string;
  brandPerceptionImpact: string;
  plannedInstallDate: string;
  isNewOrReplacement: string;
  differentiationPlan: string;
  storeAgreedLocation: boolean;
  photosLink: string;
  rebatePercentage: number | '';
  clientDiscountPercentage: number | '';
  boardCost: number | '';
  labourCost: number | '';
  salesForecast12Month: number | '';
  repHoursPerMonth: number | '';
  freeSamples: number | '';
  gifts: number | '';
  cataloguesPerYear: number | '';
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

const DISPLAY_TIERS = [
  {
    value: 'High-end',
    label: 'High-end',
    description: 'Flagship experience. Bespoke fixtures, lighting, premium materials.',
    // Replace with actual image path once Rick provides images
    imagePlaceholder: true,
  },
  {
    value: 'Premium',
    label: 'Premium',
    description: 'High quality boards and fixtures. Strong brand presence.',
    imagePlaceholder: true,
  },
  {
    value: 'Mid-range',
    label: 'Mid-range',
    description: 'Standard display board with product samples.',
    imagePlaceholder: true,
  },
  {
    value: 'Basic',
    label: 'Basic',
    description: 'Simple product placement. Minimal fixtures.',
    imagePlaceholder: true,
  },
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
    opportunityDescription: '',
    competitorBrands: '',
    brandPerceptionImpact: '',
    plannedInstallDate: '',
    isNewOrReplacement: '',
    differentiationPlan: '',
    storeAgreedLocation: false,
    photosLink: '',
    rebatePercentage: '',
    clientDiscountPercentage: '',
    boardCost: '',
    labourCost: '',
    salesForecast12Month: '',
    repHoursPerMonth: '',
    freeSamples: '',
    gifts: '',
    cataloguesPerYear: '',
    skus: [{ id: '1', code: '', name: '' }],
  });

  useEffect(() => {
    const init = async () => {
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
                opportunityDescription: draft.opportunity_description || draft.display_reason || '',
                competitorBrands: draft.competitor_brands || '',
                brandPerceptionImpact: draft.brand_perception_impact || '',
                plannedInstallDate: draft.planned_install_date || '',
                isNewOrReplacement: draft.is_new_or_replacement || '',
                differentiationPlan: draft.differentiation_plan || '',
                storeAgreedLocation: draft.store_agreed_location || false,
                photosLink: draft.photos_link || '',
                rebatePercentage: draft.rebate_pct ? draft.rebate_pct * 100 : '',
                clientDiscountPercentage: draft.cogs_pct ? draft.cogs_pct * 100 : '',
                boardCost: draft.board_labour_cost || '',
                labourCost: '',
                salesForecast12Month: draft.forecast_revenue || '',
                repHoursPerMonth: draft.rep_hours_monthly || '',
                freeSamples: draft.free_samples_cost || '',
                gifts: '',
                cataloguesPerYear: draft.catalogues_qty || '',
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
    const { name, value, type } = e.target;
    if (type === 'checkbox') {
      const checked = (e.target as HTMLInputElement).checked;
      setFormData((prev) => ({ ...prev, [name]: checked }));
    } else {
      setFormData((prev) => ({
        ...prev,
        [name]: NUMERIC_FIELDS.includes(name)
          ? value === ''
            ? ''
            : parseFloat(value)
          : value,
      }));
    }
  };

  const handleSkuChange = (index: number, selectedCode: string) => {
    const newSkus = [...formData.skus];
    const product = products.find((p) => p.sku_code === selectedCode);
    newSkus[index] = {
      ...newSkus[index],
      code: selectedCode,
      name: product?.sku_name || '',
    };
    setFormData((prev) => ({ ...prev, skus: newSkus }));
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
    if (!formData.storeName.trim()) { setError('Store Name is required'); return false; }
    if (!formData.storeCode.trim()) { setError('Store Code is required'); return false; }
    if (!formData.salesRep.trim()) { setError('Sales Rep is required'); return false; }
    if (!formData.brandTier) { setError('Please select the type of display'); return false; }
    if (!formData.displayType) { setError('Display Type is required'); return false; }
    if (!formData.opportunityDescription.trim()) { setError('Please describe the opportunity'); return false; }
    if (!formData.competitorBrands.trim()) { setError('Please list the 3 closest competitor brands'); return false; }
    if (!formData.brandPerceptionImpact) { setError('Please select the brand perception impact'); return false; }
    if (!formData.plannedInstallDate) { setError('Please enter the planned installation date'); return false; }
    if (!formData.isNewOrReplacement) { setError('Please select whether this is a new display or replacement'); return false; }
    if (formData.salesForecast12Month === '' || formData.salesForecast12Month === null) {
      setError('12 Month Sales Forecast is required'); return false;
    }
    if (formData.skus.length === 0) { setError('At least one SKU is required'); return false; }
    const validSkus = formData.skus.every((sku) => sku.code.trim() && sku.name.trim());
    if (!validSkus) { setError('All SKUs must have a product selected'); return false; }
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
      display_reason: '', // legacy field
      opportunity_description: formData.opportunityDescription,
      competitor_brands: formData.competitorBrands,
      brand_perception_impact: formData.brandPerceptionImpact,
      planned_install_date: formData.plannedInstallDate || null,
      is_new_or_replacement: formData.isNewOrReplacement,
      differentiation_plan: formData.differentiationPlan,
      store_agreed_location: formData.storeAgreedLocation,
      rebate_pct: formData.rebatePercentage === '' ? 0 : formData.rebatePercentage,
      cogs_pct: formData.clientDiscountPercentage === '' ? 0 : formData.clientDiscountPercentage,
      board_labour_cost: boardLabourCost,
      forecast_revenue: formData.salesForecast12Month === '' ? 0 : formData.salesForecast12Month,
      rep_hours_monthly: formData.repHoursPerMonth === '' ? 0 : formData.repHoursPerMonth,
      free_samples_cost: freeSamplesCost,
      catalogues_qty: formData.cataloguesPerYear === '' ? 0 : formData.cataloguesPerYear,
      product_cogs: 0,
      photos_link: formData.photosLink,
      comments: '',
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

    if (!validateForm()) return;

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

  const inputClass = 'w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500';
  const labelClass = 'block text-sm font-medium text-gray-700 mb-2';

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
              : 'Complete the form below to submit a new display request.'}
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

          {/* ===== Store Details ===== */}
          <div className="rounded-lg bg-white p-6 shadow">
            <h2 className="mb-6 text-xl font-semibold text-gray-900">Store Details</h2>

            <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
              <div>
                <label className={labelClass}>
                  Store Name <span className="text-red-500">*</span>
                </label>
                <input type="text" name="storeName" value={formData.storeName} onChange={handleInputChange} className={inputClass} placeholder="Enter store name" required />
              </div>

              <div>
                <label className={labelClass}>
                  Store Code <span className="text-red-500">*</span>
                </label>
                <input type="text" name="storeCode" value={formData.storeCode} onChange={handleInputChange} className={inputClass} placeholder="Enter store code" required />
              </div>

              <div>
                <label className={labelClass}>
                  Sales Rep <span className="text-red-500">*</span>
                </label>
                <input type="text" name="salesRep" value={formData.salesRep} onChange={handleInputChange} className={inputClass} placeholder="Enter sales rep name or email" required />
              </div>

              <div>
                <label className={labelClass}>
                  Display Type <span className="text-red-500">*</span>
                </label>
                <select name="displayType" value={formData.displayType} onChange={handleInputChange} className={inputClass} required>
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

            {/* Display Tier Visual Selector */}
            <div className="mt-6">
              <label className={labelClass}>
                Select the type of display <span className="text-red-500">*</span>
              </label>
              <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mt-2">
                {DISPLAY_TIERS.map((tier) => (
                  <button
                    key={tier.value}
                    type="button"
                    onClick={() => setFormData((prev) => ({ ...prev, brandTier: tier.value }))}
                    className={`relative rounded-lg border-2 p-4 text-left transition-all ${
                      formData.brandTier === tier.value
                        ? 'border-blue-500 bg-blue-50 ring-1 ring-blue-500'
                        : 'border-gray-200 hover:border-gray-300 bg-white'
                    }`}
                  >
                    {/* Placeholder for display tier image — replace with actual images */}
                    <div className="w-full h-24 bg-gray-100 rounded mb-3 flex items-center justify-center text-gray-400 text-xs">
                      Image coming soon
                    </div>
                    <p className={`font-semibold text-sm ${
                      formData.brandTier === tier.value ? 'text-blue-700' : 'text-gray-900'
                    }`}>
                      {tier.label}
                    </p>
                    <p className="text-xs text-gray-500 mt-1">{tier.description}</p>
                    {formData.brandTier === tier.value && (
                      <div className="absolute top-2 right-2 w-5 h-5 bg-blue-500 rounded-full flex items-center justify-center">
                        <svg className="w-3 h-3 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={3} d="M5 13l4 4L19 7" />
                        </svg>
                      </div>
                    )}
                  </button>
                ))}
              </div>
            </div>

            {/* Is this new or replacement? */}
            <div className="mt-6">
              <label className={labelClass}>
                Is this a new display or a replacement/update? <span className="text-red-500">*</span>
              </label>
              <div className="flex gap-4">
                {[
                  { value: 'new', label: 'New display' },
                  { value: 'replacement', label: 'Replacing an existing display' },
                  { value: 'update', label: 'Updating/refreshing an existing display' },
                ].map((opt) => (
                  <label
                    key={opt.value}
                    className={`flex-1 cursor-pointer rounded-lg border-2 px-4 py-3 text-center text-sm font-medium transition-all ${
                      formData.isNewOrReplacement === opt.value
                        ? 'border-blue-500 bg-blue-50 text-blue-700'
                        : 'border-gray-200 text-gray-600 hover:border-gray-300'
                    }`}
                  >
                    <input
                      type="radio"
                      name="isNewOrReplacement"
                      value={opt.value}
                      checked={formData.isNewOrReplacement === opt.value}
                      onChange={handleInputChange}
                      className="sr-only"
                    />
                    {opt.label}
                  </label>
                ))}
              </div>
            </div>
          </div>

          {/* ===== About This Opportunity ===== */}
          <div className="rounded-lg bg-white p-6 shadow">
            <h2 className="mb-6 text-xl font-semibold text-gray-900">About This Opportunity</h2>

            <div className="space-y-6">
              <div>
                <label className={labelClass}>
                  Please describe the opportunity <span className="text-red-500">*</span>
                </label>
                <textarea
                  name="opportunityDescription"
                  value={formData.opportunityDescription}
                  onChange={handleInputChange}
                  rows={3}
                  className={inputClass}
                  placeholder="What is the opportunity here? Why should we invest in this display?"
                ></textarea>
              </div>

              <div>
                <label className={labelClass}>
                  What will be the 3 closest competitor brands to this new display? <span className="text-red-500">*</span>
                </label>
                <textarea
                  name="competitorBrands"
                  value={formData.competitorBrands}
                  onChange={handleInputChange}
                  rows={2}
                  className={inputClass}
                  placeholder="e.g. Phoenix Tapware, Caroma, Grohe"
                ></textarea>
              </div>

              <div>
                <label className={labelClass}>
                  Will this display increase our brand perception, make no change, or reduce it? <span className="text-red-500">*</span>
                </label>
                <select
                  name="brandPerceptionImpact"
                  value={formData.brandPerceptionImpact}
                  onChange={handleInputChange}
                  className={inputClass}
                  required
                >
                  <option value="">Select one</option>
                  <option value="increase">Increase brand perception</option>
                  <option value="no_change">No change to brand perception</option>
                  <option value="reduce">Reduce brand perception</option>
                </select>
                {formData.brandPerceptionImpact === 'reduce' && (
                  <p className="mt-2 text-sm text-red-600 bg-red-50 border border-red-200 rounded p-2">
                    If this display will reduce brand perception, it is unlikely to be approved. Please reconsider the design or location before submitting.
                  </p>
                )}
                {formData.brandPerceptionImpact === 'no_change' && (
                  <p className="mt-2 text-sm text-amber-700 bg-amber-50 border border-amber-200 rounded p-2">
                    Our goal is to increase brand perception with every display. If there is no uplift, consider how the design or positioning could be improved.
                  </p>
                )}
              </div>

              <div>
                <label className={labelClass}>
                  How will this display stand out from surrounding brands?
                </label>
                <textarea
                  name="differentiationPlan"
                  value={formData.differentiationPlan}
                  onChange={handleInputChange}
                  rows={2}
                  className={inputClass}
                  placeholder="What makes this display stand out? Think about positioning, lighting, materials, signage."
                ></textarea>
              </div>

              <div>
                <label className={labelClass}>
                  Date when the display will be installed by <span className="text-red-500">*</span>
                </label>
                <input
                  type="date"
                  name="plannedInstallDate"
                  value={formData.plannedInstallDate}
                  onChange={handleInputChange}
                  className={inputClass}
                  required
                />
                <p className="mt-1 text-xs text-gray-500">Please be accurate with the date you enter</p>
              </div>

              <div>
                <label className="flex items-start gap-3 cursor-pointer">
                  <input
                    type="checkbox"
                    name="storeAgreedLocation"
                    checked={formData.storeAgreedLocation}
                    onChange={handleInputChange}
                    className="mt-1 h-4 w-4 rounded border-gray-300 text-blue-600 focus:ring-blue-500"
                  />
                  <span className="text-sm text-gray-700">
                    The store has agreed to the proposed display location
                  </span>
                </label>
              </div>

              <div>
                <label className={labelClass}>
                  Photos of the installation area
                </label>
                <input
                  type="text"
                  name="photosLink"
                  value={formData.photosLink}
                  onChange={handleInputChange}
                  className={inputClass}
                  placeholder="Paste a link to photos (Google Drive, Dropbox, etc.)"
                />
                <p className="mt-1 text-xs text-gray-500">
                  Upload photos of the proposed area to Google Drive or Dropbox and paste the share link here.
                  Include photos of: the installation area, surrounding brands, and the current display (if replacing).
                </p>
              </div>
            </div>
          </div>

          {/* ===== Financial Details ===== */}
          <div className="rounded-lg bg-white p-6 shadow">
            <h2 className="mb-6 text-xl font-semibold text-gray-900">Financial Details</h2>

            <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
              <div>
                <label className={labelClass}>Rebate %</label>
                <input type="number" name="rebatePercentage" value={formData.rebatePercentage} onChange={handleInputChange} min="0" max="100" step="0.1" className={inputClass} placeholder="0" />
              </div>

              <div>
                <label className={labelClass}>Client Discount %</label>
                <input type="number" name="clientDiscountPercentage" value={formData.clientDiscountPercentage} onChange={handleInputChange} min="0" max="100" step="0.1" className={inputClass} placeholder="0" />
              </div>

              <div>
                <label className={labelClass}>Board Cost Materials $</label>
                <input type="number" name="boardCost" value={formData.boardCost} onChange={handleInputChange} min="0" step="0.01" className={inputClass} placeholder="0.00" />
              </div>

              <div>
                <label className={labelClass}>Display Board Labour Cost $</label>
                <input type="number" name="labourCost" value={formData.labourCost} onChange={handleInputChange} min="0" step="0.01" className={inputClass} placeholder="0.00" />
              </div>

              <div>
                <label className={labelClass}>
                  12 Month Sales Forecast $ <span className="text-red-500">*</span>
                </label>
                <input type="number" name="salesForecast12Month" value={formData.salesForecast12Month} onChange={handleInputChange} min="0" step="0.01" className={inputClass} placeholder="0.00" required />
                <p className="mt-1 text-xs text-gray-500">This value cannot be changed after submission</p>
              </div>

              <div>
                <label className={labelClass}>
                  Amount of hours you will spend with this client each month
                </label>
                <input type="number" name="repHoursPerMonth" value={formData.repHoursPerMonth} onChange={handleInputChange} min="0" step="0.5" className={inputClass} placeholder="0" />
              </div>

              <div>
                <label className={labelClass}>Free Samples $</label>
                <input type="number" name="freeSamples" value={formData.freeSamples} onChange={handleInputChange} min="0" step="0.01" className={inputClass} placeholder="0.00" />
                <p className="mt-1 text-xs text-gray-500">
                  This is the total amount of free samples you expect to provide them in 12 months
                </p>
              </div>

              <div>
                <label className={labelClass}>Gifts $</label>
                <input type="number" name="gifts" value={formData.gifts} onChange={handleInputChange} min="0" step="0.01" className={inputClass} placeholder="0.00" />
                <p className="mt-1 text-xs text-gray-500">
                  Enter all estimated costs for the next 12 months including buying lunch, wine, store gifts, or any other expense
                </p>
              </div>

              <div>
                <label className={labelClass}>Catalogues per Year</label>
                <input type="number" name="cataloguesPerYear" value={formData.cataloguesPerYear} onChange={handleInputChange} min="0" className={inputClass} placeholder="0" />
              </div>
            </div>
          </div>

          {/* ===== SKUs ===== */}
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
                    <label className={labelClass}>SKU Code</label>
                    {products.length > 0 ? (
                      <select
                        value={sku.code}
                        onChange={(e) => handleSkuChange(index, e.target.value)}
                        className={inputClass}
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
                        className={inputClass}
                        placeholder="Enter SKU code"
                        required
                      />
                    )}
                  </div>

                  <div className="flex-1">
                    <label className={labelClass}>SKU Name</label>
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

          {/* ===== Action Buttons ===== */}
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
