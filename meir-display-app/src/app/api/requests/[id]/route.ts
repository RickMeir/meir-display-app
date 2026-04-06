import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';

export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const supabase = await createClient();

    // Check authentication
    const {
      data: { user },
    } = await supabase.auth.getUser();

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const { id } = params;

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

    // Fetch the request with SKUs and photos
    const { data: displayRequest, error } = await supabase
      .from('display_requests')
      .select(
        `
        *,
        display_skus (*),
        request_photos (*)
      `
      )
      .eq('id', id)
      .single();

    if (error || !displayRequest) {
      return NextResponse.json(
        { error: 'Request not found' },
        { status: 404 }
      );
    }

    // Strip financial fields for reps
    let processedRequest = displayRequest;
    if (role === 'rep') {
      const { net_contribution, net_margin, profitability_flag, gross_profit, gross_margin, ...rest } = displayRequest;
      processedRequest = rest;
    }

    return NextResponse.json(processedRequest, { status: 200 });
  } catch (error) {
    console.error('GET /api/requests/[id] error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
