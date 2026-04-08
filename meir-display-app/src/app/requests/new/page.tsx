'use client';

import { useState, useEffect, useRef } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';
import { Camera, X, Upload, AlertTriangle, CheckCircle, XCircle, ShieldCheck } from 'lucide-react';

interface Product {
  sku_code: string;
  sku_name: string;
}

interface SKURow {
  id: string;
  code: string;
  name: string;
}

interface UploadedPhoto {
  id: string;
  photo_url: string;
  storage_path: string;
  photo_type: string;
  filename: string;
}

interface DisplayFitting {
  fitting_sku: string;
  description: string;
  qty_per_sku: number;
  trigger_prefixes: string[];
}

interface MatchedFitting {
  fitting: DisplayFitting;
  triggered_by: string[];
  total_qty: number;
}

interface ClientBaseline {
  customer_group: string;
  customer_code: string | null;
  net_sales: number;
  cogs: number;
  cogs_pct: number;
  order_count: number;
  avg_order_value: number;
  display_costs: number;
  margin_before_ops: number;
  margin_pct: number;
  rebate_pct: number;
}

interface FormData {
  storeName: string;
  storeCode: string;
  salesRep: string;
  brandTier: string;
  displayType: string;
  isExistingClient: boolean;
  opportunityDescription: string;
  competitorBrands: string;
  brandAcknowledged: boolean;
  plannedInstallDate: string;
  isNewOrReplacement: string;
  differentiationPlan: string;
  storeAgreedLocation: boolean;
  hasInitialOrder: boolean;
  initialOrderValue: number | '';
  initialOrderNotes: string;
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
  'initialOrderValue',
];

const DISPLAY_TIERS = [
  {
    value: 'High-end',
    label: 'High-end',
    description: 'Flagship experience. Bespoke fixtures, lighting, premium materials.',
    imageUrl: 'https://drive.google.com/thumbnail?id=1IGkKKq4vwfFVQFSrblxR4VH7HojHoQ1i&sz=w400',
  },
  {
    value: 'Premium',
    label: 'Premium',
    description: 'High quality boards and fixtures. Strong brand presence.',
    imageUrl: 'https://drive.google.com/thumbnail?id=1-yhdzE3iFAD8E6x8qaxAEUnjUI1e7-46&sz=w400',
  },
  {
    value: 'Mid-range',
    label: 'Mid-range',
    description: 'Standard display board with product samples.',
    imageUrl: 'https://drive.google.com/thumbnail?id=1KVim7J251bGgY2e1ehCO7ghmhgupOyTZ&sz=w400',
  },
  {
    value: 'Basic',
    label: 'Basic',
    description: 'Simple product placement. Minimal fixtures.',
    imageUrl: 'https://drive.google.com/thumbnail?id=10ZelT8RtDsDCOv8lySXERfz6D2ReMJj2&sz=w400',
  },
];

const PHOTO_CATEGORIES = [
  {
    type: 'location',
    title: 'Display location photos',
    required: true,
    guidance: 'Take photos of where the display will be installed. We need to see the area, not just a close-up of a shelf.',
    tips: [
      'Stand back far enough to show the full area and surrounding displays',
      'Show what brands are on either side of where our display will go',
      'Include at least one wide shot of the store section so we can see the context',
    ],
  },
  {
    type: 'design_rendering',
    title: 'Display design or mockup',
    required: false,
    guidance: 'If available, upload the design rendering or mockup showing what the finished display will look like.',
    tips: [
      'This is usually provided by the design team',
      'If you do not have a mockup yet, that is OK — leave this blank and it can be added later',
    ],
  },
  {
    type: 'current_display',
    title: 'Current display photos (if replacing)',
    required: false,
    guidance: 'If this is replacing an existing display, upload photos of what is there now.',
    tips: [
      'Show the full current display, not just a close-up',
      'Include any damage or wear that justifies the replacement',
    ],
  },
];

// Photo upload component for a single category
function PhotoUploader({
  category,
  photos,
  onUpload,
  onRemove,
  uploading,
  requestId,
}: {
  category: typeof PHOTO_CATEGORIES[number];
  photos: UploadedPhoto[];
  onUpload: (file: File, photoType: string) => void;
  onRemove: (photo: UploadedPhoto) => void;
  uploading: boolean;
  requestId: string | null;
}) {
  const inputRef = useRef<HTMLInputElement>(null);
  const categoryPhotos = photos.filter((p) => p.photo_type === category.type);

  return (
    <div className="border border-gray-200 rounded-lg p-4">
      <div className="flex items-start justify-between mb-2">
        <div>
          <h4 className="text-sm font-medium text-gray-900">
            {category.title}
            {category.required && <span className="text-red-500 ml-1">*</span>}
          </h4>
          <p className="text-xs text-gray-500 mt-1">{category.guidance}</p>
        </div>
      </div>

      {/* Tips */}
      <div className="bg-blue-50 border border-blue-100 rounded p-3 mb-3">
        <p className="text-xs font-medium text-blue-800 mb-1">Tips for good photos:</p>
        <ul className="text-xs text-blue-700 space-y-0.5">
          {category.tips.map((tip, i) => (
            <li key={i} className="flex items-start gap-1.5">
              <span className="text-blue-400 mt-0.5">•</span>
              {tip}
            </li>
          ))}
        </ul>
      </div>

      {/* Uploaded photos grid */}
      {categoryPhotos.length > 0 && (
        <div className="grid grid-cols-2 sm:grid-cols-3 gap-3 mb-3">
          {categoryPhotos.map((photo) => (
            <div key={photo.id} className="relative group">
              <img
                src={photo.photo_url}
                alt={photo.filename}
                className="w-full h-24 sm:h-32 object-cover rounded border border-gray-200"
              />
              <button
                type="button"
                onClick={() => onRemove(photo)}
                className="absolute top-1 right-1 w-6 h-6 bg-red-500 text-white rounded-full flex items-center justify-center opacity-80 hover:opacity-100 transition-opacity"
              >
                <X className="w-3 h-3" />
              </button>
              <p className="text-xs text-gray-500 truncate mt-1">{photo.filename}</p>
            </div>
          ))}
        </div>
      )}

      {/* Upload button */}
      <input
        ref={inputRef}
        type="file"
        accept="image/*"
        capture="environment"
        className="hidden"
        onChange={(e) => {
          const file = e.target.files?.[0];
          if (file) onUpload(file, category.type);
          e.target.value = '';
        }}
      />
      <button
        type="button"
        onClick={() => inputRef.current?.click()}
        disabled={uploading}
        className="w-full flex items-center justify-center gap-2 px-4 py-3 border-2 border-dashed border-gray-300 rounded-lg text-sm text-gray-600 hover:border-blue-400 hover:text-blue-600 transition-colors disabled:opacity-50"
      >
        {uploading ? (
          <>
            <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-blue-600"></div>
            Uploading...
          </>
        ) : (
          <>
            <Camera className="w-4 h-4" />
            Take photo or choose from gallery
          </>
        )}
      </button>
    </div>
  );
}

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
  const [photos, setPhotos] = useState<UploadedPhoto[]>([]);
  const [photoUploading, setPhotoUploading] = useState(false);
  const [showBrandModal, setShowBrandModal] = useState(true);
  const [clientSearchResults, setClientSearchResults] = useState<ClientBaseline[]>([]);
  const [selectedBaseline, setSelectedBaseline] = useState<ClientBaseline | null>(null);
  const [clientSearchOpen, setClientSearchOpen] = useState(false);
  const [clientSearchLoading, setClientSearchLoading] = useState(false);
  const clientSearchRef = useRef<HTMLDivElement>(null);
  const [repUsers, setRepUsers] = useState<{ id: string; name: string; email: string }[]>([]);
  const [fittingsRules, setFittingsRules] = useState<DisplayFitting[]>([]);
  const [matchedFittings, setMatchedFittings] = useState<MatchedFitting[]>([]);

  const [formData, setFormData] = useState<FormData>({
    storeName: '',
    storeCode: '',
    salesRep: '',
    brandTier: '',
    displayType: '',
    isExistingClient: false,
    opportunityDescription: '',
    competitorBrands: '',
    brandAcknowledged: false,
    plannedInstallDate: '',
    isNewOrReplacement: '',
    differentiationPlan: '',
    storeAgreedLocation: false,
    hasInitialOrder: false,
    initialOrderValue: '',
    initialOrderNotes: '',
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
        setFormData((prev) => ({ ...prev, salesRep: user.email! }));
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

      // Load sales reps for the dropdown
      try {
        const { data: reps } = await supabase
          .from('users')
          .select('id, name, email')
          .eq('is_active', true)
          .in('role', ['rep', 'manager', 'admin'])
          .order('name');
        if (reps) setRepUsers(reps);
      } catch (err) {
        console.warn('Could not load reps list:', err);
      }

      // Load display fittings rules for auto-add logic
      try {
        const fittingsRes = await fetch('/api/fittings');
        if (fittingsRes.ok) {
          const fittingsJson = await fittingsRes.json();
          setFittingsRules(fittingsJson.data || []);
        }
      } catch (err) {
        console.warn('Could not load fittings rules:', err);
      }

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
                isExistingClient: draft.is_existing_client || false,
                opportunityDescription: draft.opportunity_description || draft.display_reason || '',
                competitorBrands: draft.competitor_brands || '',
                brandAcknowledged: false,
                plannedInstallDate: draft.planned_install_date || '',
                isNewOrReplacement: draft.is_new_or_replacement || '',
                differentiationPlan: draft.differentiation_plan || '',
                storeAgreedLocation: draft.store_agreed_location || false,
                hasInitialOrder: draft.has_initial_order || false,
                initialOrderValue: draft.initial_order_value || '',
                initialOrderNotes: draft.initial_order_notes || '',
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

              // Load existing photos for this draft
              if (draft.request_photos) {
                setPhotos(draft.request_photos.map((p: any) => ({
                  id: p.id,
                  photo_url: p.photo_url,
                  storage_path: p.storage_path,
                  photo_type: p.photo_type,
                  filename: p.filename,
                })));
              }
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

  // Client search for existing client dropdown
  const searchClients = async (term: string) => {
    if (term.length < 2) {
      setClientSearchResults([]);
      return;
    }
    setClientSearchLoading(true);
    try {
      const res = await fetch(`/api/clients?search=${encodeURIComponent(term)}`);
      if (res.ok) {
        const data = await res.json();
        setClientSearchResults(data);
        setClientSearchOpen(true);
      }
    } catch {
      console.warn('Client search failed');
    }
    setClientSearchLoading(false);
  };

  const selectClient = (client: ClientBaseline) => {
    setSelectedBaseline(client);
    setFormData((prev) => ({
      ...prev,
      storeName: client.customer_group,
      storeCode: client.customer_code || prev.storeCode,
      clientDiscountPercentage: client.cogs_pct ? Math.round(client.cogs_pct * 10000) / 100 : prev.clientDiscountPercentage,
      rebatePercentage: client.rebate_pct ? Math.round(client.rebate_pct * 10000) / 100 : prev.rebatePercentage,
    }));
    setClientSearchOpen(false);
  };

  // Close dropdown on click outside
  useEffect(() => {
    const handleClickOutside = (e: MouseEvent) => {
      if (clientSearchRef.current && !clientSearchRef.current.contains(e.target as Node)) {
        setClientSearchOpen(false);
      }
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  // Auto-match display fittings when SKU selections change
  useEffect(() => {
    if (fittingsRules.length === 0) return;
    const selectedCodes = formData.skus.map((s) => s.code).filter(Boolean);
    if (selectedCodes.length === 0) {
      setMatchedFittings([]);
      return;
    }

    const matches: MatchedFitting[] = [];
    for (const rule of fittingsRules) {
      const triggeredBy: string[] = [];
      for (const code of selectedCodes) {
        // Check if any trigger prefix matches the start of the selected SKU code
        for (const prefix of rule.trigger_prefixes) {
          if (code.toUpperCase().startsWith(prefix.toUpperCase())) {
            triggeredBy.push(code);
            break;
          }
        }
      }
      if (triggeredBy.length > 0) {
        matches.push({
          fitting: rule,
          triggered_by: triggeredBy,
          total_qty: rule.qty_per_sku * triggeredBy.length,
        });
      }
    }
    setMatchedFittings(matches);
  }, [formData.skus, fittingsRules]);

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
          ? value === '' ? '' : parseFloat(value)
          : value,
      }));
    }
  };

  const handleSkuChange = (index: number, selectedCode: string) => {
    const newSkus = [...formData.skus];
    const product = products.find((p) => p.sku_code === selectedCode);
    newSkus[index] = { ...newSkus[index], code: selectedCode, name: product?.sku_name || '' };
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
      setFormData((prev) => ({ ...prev, skus: prev.skus.filter((sku) => sku.id !== id) }));
    }
  };

  // Photo upload handler
  async function handlePhotoUpload(file: File, photoType: string) {
    setPhotoUploading(true);
    setError(null);

    const formDataUpload = new FormData();
    formDataUpload.append('file', file);
    formDataUpload.append('photo_type', photoType);
    if (currentDraftId) {
      formDataUpload.append('request_id', currentDraftId);
    }

    try {
      const res = await fetch('/api/photos/upload', {
        method: 'POST',
        body: formDataUpload,
      });

      const data = await res.json();

      if (!res.ok) {
        setError(data.error || 'Photo upload failed');
      } else {
        setPhotos((prev) => [
          ...prev,
          {
            id: data.data.photo_id || `temp-${Date.now()}`,
            photo_url: data.data.photo_url,
            storage_path: data.data.storage_path,
            photo_type: data.data.photo_type,
            filename: data.data.filename,
          },
        ]);
      }
    } catch {
      setError('Network error uploading photo. Please try again.');
    } finally {
      setPhotoUploading(false);
    }
  }

  async function handlePhotoRemove(photo: UploadedPhoto) {
    try {
      await fetch(`/api/photos/upload?id=${photo.id}&path=${encodeURIComponent(photo.storage_path)}`, {
        method: 'DELETE',
      });
      setPhotos((prev) => prev.filter((p) => p.id !== photo.id));
    } catch {
      setError('Failed to remove photo');
    }
  }

  const validateForm = (): boolean => {
    if (!formData.storeName.trim()) { setError('Store Name is required'); return false; }
    if (!formData.storeCode.trim()) { setError('Store Code is required'); return false; }
    if (!formData.salesRep.trim()) { setError('Sales Rep is required'); return false; }
    if (formData.isNewOrReplacement !== 'update' && !formData.brandTier) { setError('Please select the type of display'); return false; }
    if (!formData.displayType) { setError('Display Type is required'); return false; }
    if (!formData.opportunityDescription.trim()) { setError('Please describe the opportunity'); return false; }
    if (!formData.competitorBrands.trim()) { setError('Please list the 3 closest competitor brands'); return false; }
    if (!formData.brandAcknowledged) { setError('Please read and acknowledge the Meir Brand Standard before submitting'); return false; }
    if (!formData.plannedInstallDate) { setError('Please enter the planned installation date'); return false; }
    if (!formData.isNewOrReplacement) { setError('Please select whether this is a new display or replacement'); return false; }
    if (formData.salesForecast12Month === '' || formData.salesForecast12Month === null) {
      setError('Sales forecast is required — how much do you expect this display to increase sales?'); return false;
    }

    // Check for location photos
    const locationPhotos = photos.filter((p) => p.photo_type === 'location');
    if (locationPhotos.length === 0) {
      setError('Please upload at least one photo of the display location. This is required for approval.');
      return false;
    }

    if (formData.skus.length === 0) { setError('At least one SKU is required'); return false; }
    const validSkus = formData.skus.every((sku) => sku.code.trim() && sku.name.trim());
    if (!validSkus) { setError('All display products must have a product selected'); return false; }
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
      display_reason: '',
      is_existing_client: formData.isExistingClient,
      opportunity_description: formData.opportunityDescription,
      competitor_brands: formData.competitorBrands,
      brand_perception_impact: 'acknowledged',
      planned_install_date: formData.plannedInstallDate || null,
      is_new_or_replacement: formData.isNewOrReplacement,
      differentiation_plan: formData.differentiationPlan,
      store_agreed_location: formData.storeAgreedLocation,
      has_initial_order: formData.hasInitialOrder,
      initial_order_value: formData.initialOrderValue === '' ? 0 : formData.initialOrderValue,
      initial_order_notes: formData.initialOrderNotes,
      rebate_pct: formData.rebatePercentage === '' ? 0 : formData.rebatePercentage,
      cogs_pct: formData.clientDiscountPercentage === '' ? 0 : formData.clientDiscountPercentage,
      board_labour_cost: boardLabourCost,
      forecast_revenue: formData.salesForecast12Month === '' ? 0 : formData.salesForecast12Month,
      rep_hours_monthly: formData.repHoursPerMonth === '' ? 0 : formData.repHoursPerMonth,
      free_samples_cost: freeSamplesCost,
      catalogues_qty: formData.cataloguesPerYear === '' ? 0 : formData.cataloguesPerYear,
      product_cogs: 0,
      photos_link: '',
      comments: '',
      skus: formData.skus.map((sku) => ({ code: sku.code, name: sku.name })),
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
      setTimeout(() => { router.push('/requests?success=true'); }, 500);
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
            <div className="mb-8 h-10 w-48 rounded bg-gray-300"></div>
            <div className="h-64 rounded-lg bg-gray-300"></div>
          </div>
        </div>
      </main>
    );
  }

  const inputClass = 'w-full rounded border border-gray-300 bg-white px-3 py-2 text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 text-base';
  const labelClass = 'block text-sm font-medium text-gray-700 mb-2';

  return (
    <main className="min-h-screen bg-gray-50 py-6 sm:py-8">
      <div className="mx-auto max-w-4xl px-4">
        <div className="mb-6 sm:mb-8">
          <h1 className="text-2xl sm:text-3xl font-bold text-gray-900">
            {currentDraftId ? 'Edit Draft' : 'New Display Request'}
          </h1>
          <p className="mt-2 text-gray-600 text-sm sm:text-base">
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

        <form onSubmit={handleSubmit} className="space-y-6 sm:space-y-8">

          {/* ===== Store Details ===== */}
          <div className="rounded-lg bg-gray-400 p-4 sm:p-6 shadow">
            <h2 className="mb-4 sm:mb-6 text-lg sm:text-xl font-semibold text-gray-900">Store Details</h2>

            <div className="grid grid-cols-1 gap-4 sm:gap-6 sm:grid-cols-2">
              <div>
                <label className={labelClass}>Store Name <span className="text-red-500">*</span></label>
                <input type="text" name="storeName" value={formData.storeName} onChange={handleInputChange} className={inputClass} placeholder="Enter store name" required />
              </div>
              <div>
                <label className={labelClass}>Store Code <span className="text-red-500">*</span></label>
                <input type="text" name="storeCode" value={formData.storeCode} onChange={handleInputChange} className={inputClass} placeholder="Enter store code" required />
              </div>
              <div>
                <label className={labelClass}>Sales Rep <span className="text-red-500">*</span></label>
                {repUsers.length > 0 ? (
                  <select name="salesRep" value={formData.salesRep} onChange={handleInputChange} className={inputClass} required>
                    <option value="">Select sales rep</option>
                    {repUsers.map((rep) => (
                      <option key={rep.id} value={rep.email}>
                        {rep.name} ({rep.email})
                      </option>
                    ))}
                  </select>
                ) : (
                  <input type="text" name="salesRep" value={formData.salesRep} onChange={handleInputChange} className={inputClass} placeholder="Enter sales rep name or email" required />
                )}
              </div>
              <div>
                <label className={labelClass}>Display Type <span className="text-red-500">*</span></label>
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

            {/* Existing Client Toggle */}
            <div className="mt-6">
              <label className="inline-flex items-center gap-3 cursor-pointer">
                <span className="text-sm font-medium text-gray-700">Is this store an existing client?</span>
                <span className={`text-sm font-medium ${!formData.isExistingClient ? 'text-gray-700' : 'text-gray-400'}`}>No</span>
                <div className="relative">
                  <input
                    type="checkbox"
                    name="isExistingClient"
                    checked={formData.isExistingClient}
                    onChange={(e) => {
                      const checked = e.target.checked;
                      setFormData((prev) => ({ ...prev, isExistingClient: checked }));
                      if (!checked) {
                        setSelectedBaseline(null);
                        setClientSearchResults([]);
                      }
                    }}
                    className="sr-only"
                  />
                  <div className={`w-11 h-6 rounded-full transition-colors ${formData.isExistingClient ? 'bg-blue-500' : 'bg-gray-300'}`}></div>
                  <div className={`absolute top-0.5 left-0.5 w-5 h-5 bg-white rounded-full shadow transition-transform ${formData.isExistingClient ? 'translate-x-5' : ''}`}></div>
                </div>
                <span className={`text-sm font-medium ${formData.isExistingClient ? 'text-blue-600' : 'text-gray-400'}`}>Yes</span>
              </label>
            </div>

            {/* Existing Client Search + Baseline Panel */}
            {formData.isExistingClient && (
              <div className="mt-4 space-y-4">
                <div ref={clientSearchRef} className="relative">
                  <label className={labelClass}>Search for existing client <span className="text-red-500">*</span></label>
                  <input
                    type="text"
                    value={formData.storeName}
                    onChange={(e) => {
                      setFormData((prev) => ({ ...prev, storeName: e.target.value }));
                      searchClients(e.target.value);
                    }}
                    className={inputClass}
                    placeholder="Start typing to search clients..."
                    autoComplete="off"
                  />
                  {clientSearchLoading && (
                    <div className="absolute right-3 top-9 text-xs text-gray-400">Searching...</div>
                  )}
                  {clientSearchOpen && clientSearchResults.length > 0 && (
                    <div className="absolute z-10 w-full mt-1 bg-white border border-gray-200 rounded-lg shadow-lg max-h-60 overflow-y-auto">
                      {clientSearchResults.map((client) => (
                        <button
                          key={client.customer_group}
                          type="button"
                          onClick={() => selectClient(client)}
                          className="w-full text-left px-4 py-3 hover:bg-blue-50 border-b border-gray-100 last:border-0"
                        >
                          <div className="flex justify-between items-start">
                            <div>
                              <p className="text-sm font-medium text-gray-900">{client.customer_group}</p>
                              {client.customer_code && (
                                <p className="text-xs text-gray-500">{client.customer_code}</p>
                              )}
                            </div>
                            <div className="text-right">
                              <p className="text-sm font-medium text-gray-700">
                                ${client.net_sales.toLocaleString('en-AU', { minimumFractionDigits: 0, maximumFractionDigits: 0 })}
                              </p>
                              <p className="text-xs text-gray-500">{client.order_count} orders</p>
                            </div>
                          </div>
                        </button>
                      ))}
                    </div>
                  )}
                </div>

                {/* Confirmation that client was selected */}
                {selectedBaseline && (
                  <div className="bg-green-50 border border-green-200 rounded-lg p-3">
                    <p className="text-sm text-green-800">
                      <CheckCircle className="w-4 h-4 inline mr-1.5 -mt-0.5" />
                      Existing client selected: <strong>{selectedBaseline.customer_group}</strong>
                    </p>
                  </div>
                )}
              </div>
            )}

            {/* New or replacement — shown first so tier selector can be conditional */}
            <div className="mt-6">
              <label className={labelClass}>Is this a new display or a replacement/update? <span className="text-red-500">*</span></label>
              <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
                {[
                  { value: 'new', label: 'New display' },
                  { value: 'replacement', label: 'Replacing existing' },
                  { value: 'update', label: 'Updating/refreshing' },
                ].map((opt) => (
                  <label
                    key={opt.value}
                    className={`cursor-pointer rounded-lg border-2 px-4 py-3 text-center text-sm font-medium transition-all ${
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
                      onChange={(e) => {
                        handleInputChange(e);
                        // Clear brand tier if switching to update (no new display being installed)
                        if (e.target.value === 'update') {
                          setFormData((prev) => ({ ...prev, brandTier: '' }));
                        }
                      }}
                      className="sr-only"
                    />
                    {opt.label}
                  </label>
                ))}
              </div>
            </div>

            {/* Display Tier Visual Selector — only for new or replacement displays */}
            {formData.isNewOrReplacement !== 'update' && (
              <div className="mt-6">
                <label className={labelClass}>Select the type of display <span className="text-red-500">*</span></label>
                <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 sm:gap-4 mt-2">
                  {DISPLAY_TIERS.map((tier) => (
                    <button
                      key={tier.value}
                      type="button"
                      onClick={() => setFormData((prev) => ({ ...prev, brandTier: tier.value }))}
                      className={`relative rounded-lg border-2 p-3 sm:p-4 text-left transition-all ${
                        formData.brandTier === tier.value
                          ? 'border-blue-500 bg-blue-50 ring-1 ring-blue-500'
                          : 'border-gray-200 hover:border-gray-300 bg-white'
                      }`}
                    >
                      <div className="w-full h-28 sm:h-36 bg-gray-200 rounded mb-2 sm:mb-3 overflow-hidden">
                        {tier.imageUrl ? (
                          <img
                            src={tier.imageUrl}
                            alt={`${tier.label} Meir display`}
                            className="w-full h-full object-cover"
                            loading="lazy"
                          />
                        ) : (
                          <div className="w-full h-full flex items-center justify-center text-gray-400 text-xs">
                            Image coming soon
                          </div>
                        )}
                      </div>
                      <p className={`font-semibold text-sm ${formData.brandTier === tier.value ? 'text-blue-700' : 'text-gray-900'}`}>
                        {tier.label}
                      </p>
                      <p className="text-xs text-gray-500 mt-1 hidden sm:block">{tier.description}</p>
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
            )}
          </div>

          {/* ===== About This Opportunity ===== */}
          <div className="rounded-lg bg-gray-400 p-4 sm:p-6 shadow">
            <h2 className="mb-4 sm:mb-6 text-lg sm:text-xl font-semibold text-gray-900">About This Opportunity</h2>

            <div className="space-y-5">
              <div>
                <label className={labelClass}>Please describe the opportunity <span className="text-red-500">*</span></label>
                <textarea name="opportunityDescription" value={formData.opportunityDescription} onChange={handleInputChange} rows={3} className={inputClass} placeholder="What is the opportunity here? Why should we invest in this display?"></textarea>
              </div>

              <div>
                <label className={labelClass}>What will be the 3 closest competitor brands to this new display? <span className="text-red-500">*</span></label>
                <textarea name="competitorBrands" value={formData.competitorBrands} onChange={handleInputChange} rows={2} className={inputClass} placeholder="e.g. Phoenix Tapware, Caroma, Grohe"></textarea>
              </div>

              <div>
                <label className={labelClass}>Meir Brand Standard <span className="text-red-500">*</span></label>
                {formData.brandAcknowledged ? (
                  <div className="flex items-center gap-3 rounded-lg border-2 border-green-300 bg-green-50 p-4">
                    <CheckCircle className="h-6 w-6 text-green-600 flex-shrink-0" />
                    <div>
                      <p className="text-sm font-medium text-green-800">Brand standard acknowledged</p>
                      <p className="text-xs text-green-600 mt-0.5">You have confirmed this display will represent Meir as a premium brand.</p>
                    </div>
                  </div>
                ) : (
                  <button
                    type="button"
                    onClick={() => setShowBrandModal(true)}
                    className="w-full flex items-center gap-3 rounded-lg border-2 border-amber-300 bg-amber-50 p-4 text-left hover:bg-amber-100 transition-colors"
                  >
                    <ShieldCheck className="h-6 w-6 text-amber-600 flex-shrink-0" />
                    <div>
                      <p className="text-sm font-medium text-amber-800">Read and acknowledge the Meir Brand Standard</p>
                      <p className="text-xs text-amber-600 mt-0.5">Required before you can submit this request</p>
                    </div>
                  </button>
                )}
              </div>

              <div>
                <label className={labelClass}>How will this display stand out from surrounding brands?</label>
                <textarea name="differentiationPlan" value={formData.differentiationPlan} onChange={handleInputChange} rows={2} className={inputClass} placeholder="Think about positioning, lighting, materials, signage."></textarea>
              </div>

              <div>
                <label className={labelClass}>Date when the display will be installed by <span className="text-red-500">*</span></label>
                <input type="date" name="plannedInstallDate" value={formData.plannedInstallDate} onChange={handleInputChange} className={inputClass} required />
                <p className="mt-1 text-xs text-gray-500">Please be accurate with the date you enter</p>
              </div>

              <div>
                <label className="flex items-start gap-3 cursor-pointer">
                  <input type="checkbox" name="storeAgreedLocation" checked={formData.storeAgreedLocation} onChange={handleInputChange} className="mt-1 h-4 w-4 rounded border-gray-300 text-blue-600 focus:ring-blue-500" />
                  <span className="text-sm text-gray-700">The store has agreed to the proposed display location</span>
                </label>
              </div>
            </div>
          </div>

          {/* ===== Photos ===== */}
          <div className="rounded-lg bg-gray-400 p-4 sm:p-6 shadow">
            <h2 className="mb-2 text-lg sm:text-xl font-semibold text-gray-900">Photos</h2>
            <p className="text-sm text-gray-500 mb-4">
              Good photos are essential for approval. Without them, we cannot assess whether this display will increase our brand perception.
            </p>

            <div className="space-y-4">
              {PHOTO_CATEGORIES.map((cat) => (
                <PhotoUploader
                  key={cat.type}
                  category={cat}
                  photos={photos}
                  onUpload={handlePhotoUpload}
                  onRemove={handlePhotoRemove}
                  uploading={photoUploading}
                  requestId={currentDraftId}
                />
              ))}
            </div>
          </div>

          {/* ===== Initial Order Commitment ===== */}
          <div className="rounded-lg bg-gray-400 p-4 sm:p-6 shadow">
            <h2 className="mb-2 text-lg sm:text-xl font-semibold text-gray-900">Initial Order Commitment</h2>

            {/* Ownership reminder */}
            <div className="bg-amber-50 border border-amber-200 rounded-lg p-4 mb-5 flex items-start gap-3">
              <AlertTriangle className="w-5 h-5 text-amber-600 flex-shrink-0 mt-0.5" />
              <div>
                <p className="text-sm font-medium text-amber-800">Meir always owns the display.</p>
                <p className="text-sm text-amber-700 mt-1">
                  The store is never charged for the display itself, as the display is owned by Meir and sits on our balance sheet. However, we encourage our reps to negotiate where possible, an initial order as part of the store's commitment if we are offering no charge for the display. We do not expect a commitment, but a good partnership is about give and take.
                </p>
              </div>
            </div>

            <div className="space-y-4">
              <div>
                <label className={labelClass}>Has the store committed to an initial order? <span className="text-red-500">*</span></label>
                <div className="grid grid-cols-2 gap-3">
                  <label className={`cursor-pointer rounded-lg border-2 px-4 py-3 text-center text-sm font-medium transition-all ${
                    formData.hasInitialOrder === true
                      ? 'border-green-500 bg-green-50 text-green-700'
                      : 'border-gray-200 text-gray-600 hover:border-gray-300'
                  }`}>
                    <input type="radio" name="hasInitialOrderRadio" checked={formData.hasInitialOrder === true} onChange={() => setFormData((prev) => ({ ...prev, hasInitialOrder: true }))} className="sr-only" />
                    Yes, they have committed
                  </label>
                  <label className={`cursor-pointer rounded-lg border-2 px-4 py-3 text-center text-sm font-medium transition-all ${
                    formData.hasInitialOrder === false && formData.isNewOrReplacement !== ''
                      ? 'border-red-300 bg-red-50 text-red-700'
                      : 'border-gray-200 text-gray-600 hover:border-gray-300'
                  }`}>
                    <input type="radio" name="hasInitialOrderRadio" checked={formData.hasInitialOrder === false} onChange={() => setFormData((prev) => ({ ...prev, hasInitialOrder: false, initialOrderValue: '', initialOrderNotes: '' }))} className="sr-only" />
                    No initial order
                  </label>
                </div>
              </div>

              {formData.hasInitialOrder && (
                <>
                  <div>
                    <label className={labelClass}>Initial order value $</label>
                    <input type="number" name="initialOrderValue" value={formData.initialOrderValue} onChange={handleInputChange} min="0" step="0.01" className={inputClass} placeholder="e.g. 2000" />
                  </div>
                  <div>
                    <label className={labelClass}>Details about the commitment</label>
                    <textarea name="initialOrderNotes" value={formData.initialOrderNotes} onChange={handleInputChange} rows={2} className={inputClass} placeholder="e.g. Store has agreed to an initial stocking order of $2,000 across the full range."></textarea>
                  </div>
                </>
              )}

              {!formData.hasInitialOrder && formData.isNewOrReplacement !== '' && (
                <div className="bg-red-50 border border-red-200 rounded p-3">
                  <p className="text-sm text-red-700">
                    <strong>No commitment.</strong> This will be flagged during approval. Please add a note explaining why no initial order was negotiated.
                  </p>
                  <textarea
                    name="initialOrderNotes"
                    value={formData.initialOrderNotes}
                    onChange={handleInputChange}
                    rows={2}
                    className={`${inputClass} mt-2`}
                    placeholder="Why is there no initial order commitment?"
                  ></textarea>
                </div>
              )}
            </div>
          </div>

          {/* ===== Financial Details ===== */}
          <div className="rounded-lg bg-gray-400 p-4 sm:p-6 shadow">
            <h2 className="mb-4 sm:mb-6 text-lg sm:text-xl font-semibold text-gray-900">Financial Details</h2>

            <div className="grid grid-cols-1 gap-4 sm:gap-6 sm:grid-cols-2">
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
                <p className="mt-1 text-xs text-gray-500">This should NOT include the product costs</p>
              </div>
              <div>
                <label className={labelClass}>Display Board Labour Installation Cost $</label>
                <input type="number" name="labourCost" value={formData.labourCost} onChange={handleInputChange} min="0" step="0.01" className={inputClass} placeholder="0.00" />
                <p className="mt-1 text-xs text-gray-500">This should NOT include the product costs</p>
              </div>
              <div>
                <label className={labelClass}>How much do you expect this display to INCREASE this client&apos;s sales in the next 12 months? $ <span className="text-red-500">*</span></label>
                <input type="number" name="salesForecast12Month" value={formData.salesForecast12Month} onChange={handleInputChange} min="0" step="0.01" className={inputClass} placeholder="0.00" required />
                <p className="mt-1 text-xs text-gray-500">This value cannot be changed after submission</p>
              </div>
              <div>
                <label className={labelClass}>Amount of hours you will spend with this client each month</label>
                <input type="number" name="repHoursPerMonth" value={formData.repHoursPerMonth} onChange={handleInputChange} min="0" step="0.5" className={inputClass} placeholder="0" />
              </div>
              <div>
                <label className={labelClass}>Free Samples $</label>
                <input type="number" name="freeSamples" value={formData.freeSamples} onChange={handleInputChange} min="0" step="0.01" className={inputClass} placeholder="0.00" />
                <p className="mt-1 text-xs text-gray-500">This is the total amount of free samples you expect to provide them in 12 months</p>
              </div>
              <div>
                <label className={labelClass}>Gifts $</label>
                <input type="number" name="gifts" value={formData.gifts} onChange={handleInputChange} min="0" step="0.01" className={inputClass} placeholder="0.00" />
                <p className="mt-1 text-xs text-gray-500">All estimated costs for the next 12 months including lunch, wine, store gifts, or any other expense</p>
              </div>
              <div>
                <label className={labelClass}>How many catalogues will you issue them for the next 12 months?</label>
                <input type="number" name="cataloguesPerYear" value={formData.cataloguesPerYear} onChange={handleInputChange} min="0" className={inputClass} placeholder="0" />
              </div>
            </div>
          </div>

          {/* ===== SKUs ===== */}
          <div className="rounded-lg bg-gray-400 p-4 sm:p-6 shadow">
            <h2 className="mb-2 text-lg sm:text-xl font-semibold text-gray-900">Select all the display products here <span className="text-red-500">*</span></h2>
            <p className="mb-4 sm:mb-6 text-sm text-gray-500">Associated fitting parts will be automatically added to the list where relevant.</p>

            {products.length === 0 && (
              <div className="mb-4 rounded bg-yellow-50 border border-yellow-200 p-3 text-sm text-yellow-800">
                Product list is not yet configured. Please contact your administrator.
              </div>
            )}

            <div className="space-y-4">
              {formData.skus.map((sku, index) => (
                <div key={sku.id} className="flex flex-col sm:flex-row gap-3 sm:gap-4 sm:items-end">
                  <div className="flex-1">
                    <label className={labelClass}>SKU Code</label>
                    {products.length > 0 ? (
                      <select value={sku.code} onChange={(e) => handleSkuChange(index, e.target.value)} className={inputClass} required>
                        <option value="">Select a product</option>
                        {products.map((product) => (
                          <option key={product.sku_code} value={product.sku_code}>{product.sku_code}</option>
                        ))}
                      </select>
                    ) : (
                      <input type="text" value={sku.code} onChange={(e) => {
                        const newSkus = [...formData.skus];
                        newSkus[index] = { ...newSkus[index], code: e.target.value };
                        setFormData((prev) => ({ ...prev, skus: newSkus }));
                      }} className={inputClass} placeholder="Enter SKU code" required />
                    )}
                  </div>
                  <div className="flex-1">
                    <label className={labelClass}>SKU Name</label>
                    <input type="text" value={sku.name} readOnly className="w-full rounded border border-gray-200 bg-gray-50 px-3 py-2 text-gray-700 text-base" placeholder={products.length > 0 ? 'Auto filled from selection' : 'Enter SKU name'} />
                  </div>
                  <div>
                    <button type="button" onClick={() => removeSKU(sku.id)} disabled={formData.skus.length === 1} className="w-full sm:w-auto rounded bg-red-50 px-4 py-2 text-red-600 hover:bg-red-100 disabled:opacity-50 disabled:cursor-not-allowed font-medium text-sm">
                      Remove
                    </button>
                  </div>
                </div>
              ))}
            </div>

            <button type="button" onClick={addSKU} className="mt-4 rounded bg-blue-50 px-4 py-2 text-blue-600 hover:bg-blue-100 font-medium text-sm">
              Add Product
            </button>

            {/* Auto-matched fittings */}
            {matchedFittings.length > 0 && (
              <div className="mt-6 bg-blue-50 border border-blue-200 rounded-lg p-4">
                <h4 className="text-sm font-semibold text-blue-900 mb-3">
                  <CheckCircle className="w-4 h-4 inline mr-1.5 -mt-0.5" />
                  Associated fittings automatically added
                </h4>
                <div className="space-y-2">
                  {matchedFittings.map((match) => (
                    <div key={match.fitting.fitting_sku} className="flex justify-between items-start bg-white rounded p-3 border border-blue-100">
                      <div>
                        <p className="text-sm font-medium text-gray-900">{match.fitting.fitting_sku}</p>
                        <p className="text-xs text-gray-600">{match.fitting.description}</p>
                        <p className="text-xs text-gray-400 mt-0.5">
                          Triggered by: {match.triggered_by.join(', ')}
                        </p>
                      </div>
                      <div className="text-right shrink-0 ml-3">
                        <p className="text-sm font-bold text-blue-900">Qty: {match.total_qty}</p>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>

          {/* ===== Action Buttons ===== */}
          <div className="space-y-3 pb-8">
            {draftSaved && (
              <div className="rounded-lg bg-green-50 p-3 text-green-700 border border-green-200 text-sm text-center">
                Draft saved successfully
              </div>
            )}
            <div className="flex flex-col sm:flex-row gap-3 sm:gap-4">
              <button type="submit" disabled={submitting || saving} className="flex-1 rounded bg-blue-600 px-6 py-3 text-white font-medium hover:bg-blue-700 disabled:bg-gray-400 disabled:cursor-not-allowed text-base">
                {submitting ? 'Submitting...' : 'Submit Request'}
              </button>
              <button type="button" onClick={handleSaveDraft} disabled={saving || submitting} className="flex-1 rounded bg-gray-200 border border-gray-300 px-6 py-3 text-gray-700 font-medium hover:bg-gray-300 disabled:bg-gray-200 disabled:cursor-not-allowed text-base">
                {saving ? 'Saving...' : 'Save Draft'}
              </button>
            </div>
            <button type="button" onClick={() => router.back()} className="w-full rounded bg-gray-50 px-6 py-2 text-gray-500 font-medium hover:bg-gray-200 text-sm">
              Cancel
            </button>
          </div>
        </form>
      </div>

      {/* ===== Brand Standard Modal ===== */}
      {showBrandModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">
          <div className="max-h-[90vh] w-full max-w-lg overflow-y-auto rounded-xl bg-white shadow-2xl">
            <div className="p-6 sm:p-8">
              <div className="text-center mb-6">
                <ShieldCheck className="mx-auto h-12 w-12 text-blue-600 mb-3" />
                <h3 className="text-xl font-bold text-gray-900">Meir Brand Standard</h3>
              </div>

              <div className="space-y-5 text-sm text-gray-700 leading-relaxed">
                <p>
                  We are a global premium brand. When a customer walks into a showroom, our display must instantly communicate that fact. We do not blend in. We do not look like just another tapware option on the wall.
                </p>
                <p>
                  If a display looks average, we do not approve it. We would rather have fewer, exceptional displays than be everywhere looking average.
                </p>

                <div className="rounded-lg border-2 border-amber-300 bg-amber-50 p-4">
                  <p className="text-amber-900 font-semibold text-base">
                    Before you request a display, ask yourself:
                  </p>
                  <p className="text-amber-800 mt-2 italic">
                    &ldquo;Would I take a photo of this display and put it on the homepage of our website to showcase our brand?&rdquo;
                  </p>
                  <p className="text-amber-900 mt-2 font-medium">
                    If the answer is no, the display should not be installed.
                  </p>
                </div>

                <p>
                  Our products need room to breathe. Crowded displays look cheap. Give the products space so the customer can appreciate the design and finish.
                </p>
                <p>
                  We do not need every product to be on the display. Our brand is being represented, not our entire range.
                </p>
                <p>
                  We belong at eye level, in the path where customers naturally browse. We do not accept being tucked away in a corner or hidden behind other brands.
                </p>
                <p>
                  We do not sit shoulder to shoulder with discount brands. There must be a clear visual break that says Meir is in a different league.
                </p>
                <p>
                  The lighting must be excellent. The materials surrounding our products must feel high end. The branding must be proud and unmistakable.
                </p>

                <p className="font-semibold text-gray-900 text-base pt-2">
                  We are Meir. Let&rsquo;s make sure every display reflects exactly what that means.
                </p>
              </div>

              <div className="mt-8">
                <button
                  type="button"
                  onClick={() => {
                    setFormData((prev) => ({ ...prev, brandAcknowledged: true }));
                    setShowBrandModal(false);
                  }}
                  className="w-full rounded-lg bg-blue-600 px-6 py-3 text-white font-medium hover:bg-blue-700 text-base"
                >
                  I understand
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </main>
  );
}
