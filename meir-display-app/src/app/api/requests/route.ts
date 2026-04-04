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

    // Prepare request data with percentage conversion (5 -> 0.05)
    const requestData = {
      submitted_by: user.id,
      submitted_at: new Date().toISOString(),
      status: 'submitted',

      // Basic info
      display_name: body.displayName,
      brand_name: body.brandName,
      department: body.department,
      request_date: body.requestDate,

      // Display specs
      display_type: body.displayType,
      dimensions: body.dimensions,
      quantity: body.quantity,
      setup_date: body.setupDate,
      location: body.location,

      // Financial inputs (convert percentages to decimals)
      unit_cost: body.unitCost,
      list_price: body.listPrice,
      std_discount_pct: body.stdDiscountPct / 100,
      additional_discount_pct: body.additionalDiscountPct / 100,
      display_allowance_pct: body.displayAllowancePct / 100,
      broker_commission_pct: body.brokerCommissionPct / 100,

      // Calculated financial outputs
      gross_profit: financials.grossProfit,
      gross_margin: financials.grossMargin,
      net_contribution: financials.netContribution,
      net_margin: financials.netMargin,
      profitability_flag: financials.profitabilityFlag,
      approval_tier: financials.approvalTier,

      // Additional fields
      notes: body.notes || null,
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
        quantity: sku.quantity,
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
      // Don't fail the request if email fails
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

    // Check authentication
    const {
      data: { user },
    } = await supabase.auth.getUser();

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    // Get user role
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

    // Parse query parameters
    const searchParams = request.nextUrl.searchParams;
    const status = searchParams.get('status');
    const limit = parseInt(searchParams.get('limit') || '50');
    const offset = parseInt(searchParams.get('offset') || '0');

    // Build query based on role
    let query = supabase
      .from('display_requests')
      .select(
        `
        *,
        display_skus (*)
      `,
        { count: 'exact' }
      )
      .order('submitted_at', { ascending: false })
      .range(offset, offset + limit - 1);

    if (role === 'rep') {
      // Reps see only their own requests
      query = query.eq('submitted_by', user.id);
    } else if (role === 'validator') {
      // Validators see their work queue (submitted/queried) plus all for browsing
      query = query.or(
        `status.eq.submitted,status.eq.queried,submitted_by.eq.${user.id}`
      );
    }
    // admin, manager, cfo, coo see all requests

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

    // Strip financial fields for reps
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
        pagination: {
          count,
          limit,
          offset,
        },
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
