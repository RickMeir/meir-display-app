import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

/**
 * Given a list of SKU codes, returns the display fittings (parts)
 * needed for the order. Matching is done by prefix: if a selected
 * SKU starts with any trigger prefix, that fitting is included.
 *
 * POST /api/fittings
 * Body: { sku_codes: ["MW04-C", "MZ0704-PVDBB"] }
 * Response: { data: [{ fitting_sku, description, qty_per_sku, matched_by }] }
 */
export async function POST(request: NextRequest) {
  try {
    const supabase = await createClient()

    const {
      data: { user },
    } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const { sku_codes } = await request.json()

    if (!Array.isArray(sku_codes) || sku_codes.length === 0) {
      return NextResponse.json({ data: [] }, { status: 200 })
    }

    // Fetch all active fitting rules
    const { data: fittings, error } = await supabase
      .from('display_fittings')
      .select('fitting_sku, description, qty_per_sku, trigger_prefixes')
      .eq('is_active', true)

    if (error || !fittings) {
      return NextResponse.json({ data: [] }, { status: 200 })
    }

    // For each fitting, check if any selected SKU matches a trigger prefix
    const matched: {
      fitting_sku: string
      description: string
      qty_per_sku: number
      matched_by: string[]
    }[] = []

    for (const fitting of fittings) {
      const matchedSkus: string[] = []
      for (const skuCode of sku_codes) {
        const code = (skuCode as string).toUpperCase()
        for (const prefix of fitting.trigger_prefixes) {
          if (code.startsWith(prefix.toUpperCase())) {
            matchedSkus.push(skuCode as string)
            break
          }
        }
      }
      if (matchedSkus.length > 0) {
        matched.push({
          fitting_sku: fitting.fitting_sku,
          description: fitting.description,
          qty_per_sku: fitting.qty_per_sku * matchedSkus.length,
          matched_by: matchedSkus,
        })
      }
    }

    return NextResponse.json({ data: matched }, { status: 200 })
  } catch (error) {
    console.error('POST /api/fittings error:', error)
    return NextResponse.json({ data: [] }, { status: 200 })
  }
}
