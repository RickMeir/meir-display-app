import { NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

export async function GET() {
  try {
    const supabase = await createClient()

    const {
      data: { user },
    } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const { data: products, error } = await supabase
      .from('products')
      .select('sku_code, sku_name, unit_cost')
      .eq('is_active', true)
      .order('sku_code', { ascending: true })

    if (error) {
      console.error('Error fetching products:', error)
      // If the table does not exist yet, return empty array gracefully
      return NextResponse.json({ data: [] }, { status: 200 })
    }

    return NextResponse.json({ data: products || [] }, { status: 200 })
  } catch (error) {
    console.error('GET /api/products error:', error)
    return NextResponse.json({ data: [] }, { status: 200 })
  }
}
