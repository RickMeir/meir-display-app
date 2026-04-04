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
    const body: RequestFormInput = await request.json();

    // Calculate all derived financial fields
    const financials = calculateFinancials(body);

    // Prepare request data
    const requestData = {
      submitted_by: user.id,
      submitted_at: new Date().toISOString(),
      status: 'submitted',

      // Store info (snake_case from RequestFormInput)
      store_name: body.store_name,
      store_code: body.store_code,
      rep_name: body.rep_name,
      brand_tier: body.brand_tier,
      display_type: body.display_type,
      display_reason: body.display_reason,

      // Financial inputs (percentages already as numbers from RequestFormInput)
      rebate_pct: body.rebate_pct / 100,
      cogs_pct: body.cogs_pct / 100,
      board_labour_cost: body.board_labour_cost,
      forecast_revenue: body.forecast_revenue,
      rep_hours_monthly: body.rep_hours_monthly,
      free_samples_cost: body.free_samples_cost,
      catalogues_qty: body.catalogues_qty,
      product_cogs: body.product_cogs,
      photos_link: body.photos_link || null,
      comments: body.comments || null,

      // Calculated financial outputs
      total_investment: financials.total_investment,
      revenue_after_discount: financials.revenue_after_discount,
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

      // Additional fields
      approval_note: null,
      validation_note: null,
      was_override: false,
    };

    // Use service client to bypass RLS for inserts
    const serviceSupabase = await createServiceClient();

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

    // Insert SKUs
    if (body.skus && body.skus.length > 0) {
      const skuData = body.skus.map((sku) => ({
        request_id: displayRequest.id,
        sku_code: sku.code,
        sku_name: sku.name,
      }));

      const { error: skuError } = await serviceSupabase
        .from('display_skus')
        .insert(skuData);

      if (skuError) {
        console.error('Error inserting SKUs:', skuError);
        // Continue anyway - request is created
      }
    }

    // Create audit log entry
    const { error: auditError } = await serviceSupabase
      .from('audit_log')
      .insert([
        {
          request_id: displayRequest.id,
          action: 'submitted',
          performed_by: user.id,
          performed_at: new Date().toISOString(),
          details: `Request submitted with ${body.skus?.length || 0} SKUs`,
        },
      ]);

    if (auditError) {
      console.error('Error creating audit log:', auditError);
    }

    // Send validation email
    try {
      await sendValidationEmail(displayRequest);
    } catch (emailError) {
      console.error('Error sending validation email:', emailError);
    }

    return NextResponse.json({ id: displayRequest.id }, { status: 201 });
  } catch (error) {
    console.error('POST /api/requests error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
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
