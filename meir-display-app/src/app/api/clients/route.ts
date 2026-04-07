import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

// GET /api/clients — returns client baseline data for existing client dropdown
// Optional query param: ?search=term (for autocomplete)
export async function GET(request: NextRequest) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const search = request.nextUrl.searchParams.get('search') || ''

    let query = supabase
      .from('client_baseline')
      .select('customer_group, customer_code, net_sales, cogs, cogs_pct, order_count, avg_order_value, display_costs, margin_before_ops, margin_pct, rebate_pct')
      .order('net_sales', { ascending: false })

    if (search.length >= 2) {
      query = query.ilike('customer_group', `%${search}%`)
    }

    // Limit to 50 results for performance
    query = query.limit(50)

    const { data, error } = await query

    if (error) {
      console.error('Client baseline query error:', error)
      return NextResponse.json({ error: 'Failed to fetch clients' }, { status: 500 })
    }

    return NextResponse.json(data || [])
  } catch (error) {
    console.error('GET /api/clients error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
