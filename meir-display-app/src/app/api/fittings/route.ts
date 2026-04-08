import { NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

// GET /api/fittings
// Returns all active display fittings rules.
// Used by the new-request form to auto-add fitting parts
// when specific product SKU patterns are selected.

export async function GET() {
  try {
    const supabase = await createClient()

    const {
      data: { user },
    } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const { data: fittings, error } = await supabase
      .from('display_fittings')
      .select('fitting_sku, description, qty_per_sku, unit_cost, trigger_prefixes')
      .eq('is_active', true)

    if (error) {
      console.error('Error fetching fittings:', error)
      return NextResponse.json({ data: [] }, { status: 200 })
    }

    return NextResponse.json({ data: fittings || [] }, { status: 200 })
  } catch (error) {
    console.error('GET /api/fittings error:', error)
    return NextResponse.json({ data: [] }, { status: 200 })
  }
}
