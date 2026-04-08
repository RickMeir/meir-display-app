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

    // Supabase PostgREST enforces a server-side max of 1000 rows per request.
    // We have 2021+ products, so we must paginate using .range() to fetch all.
    const PAGE_SIZE = 1000
    let allProducts: { sku_code: string; sku_name: string; unit_cost: number }[] = []
    let from = 0
    let keepFetching = true

    while (keepFetching) {
      const { data: batch, error } = await supabase
        .from('products')
        .select('sku_code, sku_name, unit_cost')
        .eq('is_active', true)
        .order('sku_code', { ascending: true })
        .range(from, from + PAGE_SIZE - 1)

      if (error) {
        console.error('Error fetching products:', error)
        return NextResponse.json({ data: [] }, { status: 200 })
      }

      if (batch && batch.length > 0) {
        allProducts = allProducts.concat(batch)
        from += PAGE_SIZE
        // If we got fewer than PAGE_SIZE, we have reached the end
        if (batch.length < PAGE_SIZE) {
          keepFetching = false
        }
      } else {
        keepFetching = false
      }
    }

    return NextResponse.json({ data: allProducts }, { status: 200 })
  } catch (error) {
    console.error('GET /api/products error:', error)
    return NextResponse.json({ data: [] }, { status: 200 })
  }
}
