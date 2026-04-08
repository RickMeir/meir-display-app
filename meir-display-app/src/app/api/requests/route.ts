import { NextRequest, NextResponse } from 'next/server';
import { createClient, createServiceClient } from '@/lib/supabase/server';
import { RequestFormInput } from '@/lib/types';
import { calculateFinancials } from '@/lib/calculations';
import { sendValidationEmail } from '@/lib/email';

export async function POST(request: NextRequest) {
  try {
    const supabase = await createClient();

    // Check authentication
    const {
      data: { user },
    } = await supabase.auth.getUser();

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    // Parse request body
    const body: RequestFormInput & { save_as?: 'draft' | 'submit' } = await request.json();
    const isDraft = body.save_as === 'draft';

    // For drafts, use zeroes for missing numeric fields
    // For submissions, calculate financials normally
    const safeBody = {
      ...body,
      rebate_pct: body.rebate_pct || 0,
      cogs_pct: body.cogs_pct || 0,
      board_labour_cost: body.board_labour_cost || 0,
      forecast_revenue: body.forecast_revenue || 0,
      rep_hours_monthly: body.rep_hours_monthly || 0,
      free_samples_cost: body.free_samples_cost || 0,
      catalogues_qty: body.catalogues_qty || 0,
      product_cogs: body.product_cogs || 0,
    };

    // Look up existing client baseline if flagged
    let existingClientData = null
    if (body.is_existing_client && body.store_name) {
      const serviceClient = createServiceClient()
      const { data: baseline } = await serviceClient
        .from('client_baseline')
        .select('net_sales, order_count, avg_order_value, cogs_pct')
        .eq('customer_group', body.store_name)
        .single()

      if (baseline) {
        existingClientData = {
          annual_revenue: baseline.net_sales,
          order_count: baseline.order_count,
          avg_order_value: baseline.avg_order_value,
          cogs_pct: baseline.cogs_pct,
        }
      }
    }

    const financials = calculateFinancials(safeBody, existingClientData);

    // Calculate baseline fields
    const existingRevenue = existingClientData?.annual_revenue || 0
    const baselineRevenue = existingRevenue * 1.15  // 15% growth
    const incrementalRevenue = safeBody.forecast_revenue - baselineRevenue

    // Prepare request data
    const requestData = {
      submitted_by: user.id,
      submitted_at: isDraft ? null : new Date().toISOString(),
      status: isDraft ? 'draft' : 'submitted',

      // Store info
      store_name: body.store_name || '',
      store_code: body.store_code || '',
      rep_name: body.rep_name || '',
      brand_tier: body.brand_tier || null,
      display_type: body.display_type || null,
      display_reason: body.display_reason || null,
      opportunity_description: body.opportunity_description || null,
      competitor_brands: body.competitor_brands || null,
      brand_perception_impact: body.brand_perception_impact || null,
      planned_install_date: body.planned_install_date || null,
      is_new_or_replacement: body.is_new_or_replacement || null,
      differentiation_plan: body.differentiation_plan || null,
      store_agreed_location: body.store_agreed_location || false,

      // Existing client
      is_existing_client: body.is_existing_client || false,
      existing_annual_revenue: existingRevenue,
      existing_orders: existingClientData?.order_count || 0,
      existing_aov: existingClientData?.avg_order_value || 0,
      existing_cogs_pct: existingClientData?.cogs_pct || 0,
      baseline_revenue: body.is_existing_client ? baselineRevenue : 0,
      incremental_revenue: body.is_existing_client ? incrementalRevenue : safeBody.forecast_revenue,

      // Financial inputs
      rebate_pct: safeBody.rebate_pct / 100,
      cogs_pct: safeBody.cogs_pct / 100,
      board_labour_cost: safeBody.board_labour_cost,
      forecast_revenue: safeBody.forecast_revenue,
      rep_hours_monthly: safeBody.rep_hours_monthly,
      free_samples_cost: safeBody.free_samples_cost,
      catalogues_qty: safeBody.catalogues_qty,
      product_cogs: safeBody.product_cogs,
      photos_link: body.photos_link || null,
      comments: body.comments || null,

      // Initial order commitment
      has_initial_order: body.has_initial_order ?? false,
      initial_order_value: body.has_initial_order ? (body.initial_order_value || 0) : 0,
      initial_order_notes: body.initial_order_notes || null,

      // Calculated financial outputs
      total_investment: financials.total_investment,
      revenue_after_discount: financials.revenue_after_discount,
      net_revenue: financials.net_revenue,
      rebate_cost: financials.rebate_cost,
      cogs_on_sales: financials.cogs_on_sales,
      est_orders: financials.est_orders,
      order_processing: financials.order_processing,
      rep_visit_cost: financials.rep_visit_cost,
      catalogue_cost: financials.catalogue_cost,
      total_costs: financials.total_costs,
      gross_profit: financials.gross_profit,
      gross_margin: financials.gross_margin,
      net_contribution: financials.net_contribution,
      net_margin: financials.net_margin,
      profitability_flag: financials.profitability_flag,
      approval_tier: financials.approval_tier,
      roi_multiplier: financials.roi_multiplier,
      verdict: financials.verdict,

      // Additional fields
      approval_note: null,
      validation_note: null,
      was_override: false,
    };

    // Use service client to bypass RLS for inserts
    const serviceSupabase = createServiceClient();

    // Insert into display_requests
    const { data: displayRequest, error: requestError } =
      await serviceSupabase
        .from('display_requests')
        .insert([requestData])
        .select()
        .single();

    if (requestError) {
      console.error('Error inserting request:', requestError);
      return NextResponse.json(
        { error: 'Failed to create request' },
        { status: 500 }
      );
    }

    // Insert SKUs (if any — drafts may have none)
    const validSkus = (body.skus || []).filter((sku: any) => sku.code && sku.code.trim());
    if (validSkus.length > 0) {
      const skuData = validSkus.map((sku: any) => ({
        request_id: displayRequest.id,
        sku_code: sku.code,
        sku_name: sku.name,
        quantity: sku.qty || 1,
        unit_cost: sku.unit_cost || 0,
        line_cost: (sku.unit_cost || 0) * (sku.qty || 1),
      }));

      const { error: skuError } = await serviceSupabase
        .from('display_skus')
        .insert(skuData);

      if (skuError) {
        console.error('Error inserting SKUs:', skuError);
      }
    }

    // Create audit log entry
    await serviceSupabase
      .from('audit_log')
      .insert([
        {
          request_id: displayRequest.id,
          action: isDraft ? 'draft_saved' : 'submitted',
          performed_by: user.id,
          performed_at: new Date().toISOString(),
          details: isDraft
            ? `Draft saved for ${body.store_name || 'unnamed store'}`
            : `Request submitted with ${validSkus.length} SKUs`,
        },
      ]);

    // Only send validation email on actual submission, not drafts
    if (!isDraft) {
      try {
        await sendValidationEmail(displayRequest);
      } catch (emailError) {
        console.error('Error sending validation email:', emailError);
      }
    }

    return NextResponse.json(
      { id: displayRequest.id, status: isDraft ? 'draft' : 'submitted' },
      { status: 201 }
    );
  } catch (error) {
    console.error('POST /api/requests error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

// PUT: update an existing draft
export async function PUT(request: NextRequest) {
  try {
    const supabase = await createClient();
    const {
      data: { user },
    } = await supabase.auth.getUser();

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const body: RequestFormInput & { id: string; save_as?: 'draft' | 'submit' } = await request.json();

    if (!body.id) {
      return NextResponse.json({ error: 'Missing request ID' }, { status: 400 });
    }

    const serviceSupabase = createServiceClient();

    // Verify the draft belongs to this user and is still a draft
    const { data: existing } = await serviceSupabase
      .from('display_requests')
      .select('id, submitted_by, status')
      .eq('id', body.id)
      .single();

    if (!existing) {
      return NextResponse.json({ error: 'Request not found' }, { status: 404 });
    }

    if (existing.submitted_by !== user.id) {
      return NextResponse.json({ error: 'Not your draft' }, { status: 403 });
    }

    if (existing.status !== 'draft') {
      return NextResponse.json(
        { error: 'Only drafts can be updated. This request has already been submitted.' },
        { status: 400 }
      );
    }

    const isSubmitting = body.save_as === 'submit';

    const safeBody = {
      ...body,
      rebate_pct: body.rebate_pct || 0,
      cogs_pct: body.cogs_pct || 0,
      board_labour_cost: body.board_labour_cost || 0,
      forecast_revenue: body.forecast_revenue || 0,
      rep_hours_monthly: body.rep_hours_monthly || 0,
      free_samples_cost: body.free_samples_cost || 0,
      catalogues_qty: body.catalogues_qty || 0,
      product_cogs: body.product_cogs || 0,
    };

    // Look up existing client baseline if flagged
    let existingClientData = null
    if (body.is_existing_client && body.store_name) {
      const { data: baseline } = await serviceSupabase
        .from('client_baseline')
        .select('net_sales, order_count, avg_order_value, cogs_pct')
        .eq('customer_group', body.store_name)
        .single()

      if (baseline) {
        existingClientData = {
          annual_revenue: baseline.net_sales,
          order_count: baseline.order_count,
          avg_order_value: baseline.avg_order_value,
          cogs_pct: baseline.cogs_pct,
        }
      }
    }

    const financials = calculateFinancials(safeBody, existingClientData);

    const existingRevenue = existingClientData?.annual_revenue || 0
    const baselineRevenue = existingRevenue * 1.15
    const incrementalRevenue = safeBody.forecast_revenue - baselineRevenue

    const updateData = {
      submitted_at: isSubmitting ? new Date().toISOString() : null,
      status: isSubmitting ? 'submitted' : 'draft',
      store_name: body.store_name || '',
      store_code: body.store_code || '',
      rep_name: body.rep_name || '',
      brand_tier: body.brand_tier || null,
      display_type: body.display_type || null,
      display_reason: body.display_reason || null,
      opportunity_description: body.opportunity_description || null,
      competitor_brands: body.competitor_brands || null,
      brand_perception_impact: body.brand_perception_impact || null,
      planned_install_date: body.planned_install_date || null,
      is_new_or_replacement: body.is_new_or_replacement || null,
      differentiation_plan: body.differentiation_plan || null,
      store_agreed_location: body.store_agreed_location || false,
      is_existing_client: body.is_existing_client || false,
      existing_annual_revenue: existingRevenue,
      existing_orders: existingClientData?.order_count || 0,
      existing_aov: existingClientData?.avg_order_value || 0,
      existing_cogs_pct: existingClientData?.cogs_pct || 0,
      baseline_revenue: body.is_existing_client ? baselineRevenue : 0,
      incremental_revenue: body.is_existing_client ? incrementalRevenue : safeBody.forecast_revenue,
      rebate_pct: safeBody.rebate_pct / 100,
      cogs_pct: safeBody.cogs_pct / 100,
      board_labour_cost: safeBody.board_labour_cost,
      forecast_revenue: safeBody.forecast_revenue,
      rep_hours_monthly: safeBody.rep_hours_monthly,
      free_samples_cost: safeBody.free_samples_cost,
      catalogues_qty: safeBody.catalogues_qty,
      product_cogs: safeBody.product_cogs,
      photos_link: body.photos_link || null,
      comments: body.comments || null,
      has_initial_order: body.has_initial_order ?? false,
      initial_order_value: body.has_initial_order ? (body.initial_order_value || 0) : 0,
      initial_order_notes: body.initial_order_notes || null,
      total_investment: financials.total_investment,
      revenue_after_discount: financials.revenue_after_discount,
      net_revenue: financials.net_revenue,
      rebate_cost: financials.rebate_cost,
      cogs_on_sales: financials.cogs_on_sales,
      est_orders: financials.est_orders,
      order_processing: financials.order_processing,
      rep_visit_cost: financials.rep_visit_cost,
      catalogue_cost: financials.catalogue_cost,
      total_costs: financials.total_costs,
      gross_profit: financials.gross_profit,
      gross_margin: financials.gross_margin,
      net_contribution: financials.net_contribution,
      net_margin: financials.net_margin,
      profitability_flag: financials.profitability_flag,
      approval_tier: financials.approval_tier,
      roi_multiplier: financials.roi_multiplier,
      verdict: financials.verdict,
    };

    const { data: updated, error: updateErr } = await serviceSupabase
      .from('display_requests')
      .update(updateData)
      .eq('id', body.id)
      .select()
      .single();

    if (updateErr) {
      return NextResponse.json({ error: 'Failed to update draft' }, { status: 500 });
    }

    // Replace SKUs — delete old ones, insert new
    await serviceSupabase
      .from('display_skus')
      .delete()
      .eq('request_id', body.id);

    const validSkus = (body.skus || []).filter((sku: any) => sku.code && sku.code.trim());
    if (validSkus.length > 0) {
      await serviceSupabase
        .from('display_skus')
        .insert(validSkus.map((sku: any) => ({
          request_id: body.id,
          sku_code: sku.code,
          sku_name: sku.name,
          quantity: sku.qty || 1,
          unit_cost: sku.unit_cost || 0,
          line_cost: (sku.unit_cost || 0) * (sku.qty || 1),
        })));
    }

    // Audit log
    await serviceSupabase.from('audit_log').insert({
      request_id: body.id,
      action: isSubmitting ? 'draft_submitted' : 'draft_updated',
      performed_by: user.id,
      performed_at: new Date().toISOString(),
      details: isSubmitting
        ? `Draft submitted for ${body.store_name}`
        : `Draft updated for ${body.store_name || 'unnamed store'}`,
    });

    // Send validation email if submitting
    if (isSubmitting) {
      try {
        await sendValidationEmail(updated);
      } catch (emailError) {
        console.error('Error sending validation email:', emailError);
      }
    }

    return NextResponse.json({
      id: body.id,
      status: isSubmitting ? 'submitted' : 'draft',
    });
  } catch (error) {
    console.error('PUT /api/requests error:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

export async function GET(request: NextRequest) {
  try {
    const supabase = await createClient();

    const {
      data: { user },
    } = await supabase.auth.getUser();

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const { data: userData, error: userError } = await supabase
      .from('users')
      .select('role')
      .eq('id', user.id)
      .single();

    if (userError || !userData) {
      return NextResponse.json(
        { error: 'Failed to fetch user role' },
        { status: 500 }
      );
    }

    const role = userData.role;
    const searchParams = request.nextUrl.searchParams;
    const status = searchParams.get('status');
    const limit = parseInt(searchParams.get('limit') || '50');
    const offset = parseInt(searchParams.get('offset') || '0');

    let query = supabase
      .from('display_requests')
      .select('*, display_skus (*)', { count: 'exact' })
      .order('submitted_at', { ascending: false })
      .range(offset, offset + limit - 1);

    if (role === 'rep') {
      query = query.eq('submitted_by', user.id);
    } else if (role === 'validator') {
      query = query.or(
        `status.eq.submitted,status.eq.queried,submitted_by.eq.${user.id}`
      );
    }

    if (status) {
      query = query.eq('status', status);
    }

    const { data: requests, error, count } = await query;

    if (error) {
      console.error('Error fetching requests:', error);
      return NextResponse.json(
        { error: 'Failed to fetch requests' },
        { status: 500 }
      );
    }

    let processedRequests = requests || [];
    if (role === 'rep') {
      processedRequests = processedRequests.map((req: any) => {
        const { net_contribution, net_margin, profitability_flag, gross_profit, gross_margin, ...rest } = req;
        return rest;
      });
    }

    return NextResponse.json(
      {
        data: processedRequests,
        pagination: { count, limit, offset },
      },
      { status: 200 }
    );
  } catch (error) {
    console.error('GET /api/requests error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
