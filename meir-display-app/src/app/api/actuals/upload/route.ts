import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import * as XLSX from 'xlsx'

// The Acumatica "Daily Sales Profitability (Detailed)" report format
// Row 8 has headers (0-indexed row 7), data starts at row 9
// Columns: Customer (code), Customer Name, Customer Group, Fin. Period,
//          Doc. Date, Doc. Type, Ref. Nbr., Ship. Nbr., Warehouse,
//          Order Type, Order Nbr., Order Date, Lead Time, Currency,
//          Net Sales, Cost, **, Margin, Margin %

interface ParsedRow {
  customer_code: string
  customer_name: string
  customer_group: string
  doc_date: string
  doc_type: string
  ref_nbr: string
  order_type: string
  order_nbr: string
  net_sales: number
  cost: number
  margin: number
  margin_pct: number | null
}

function parseAcumaticaExport(buffer: ArrayBuffer): {
  rows: ParsedRow[]
  dateFrom: string | null
  dateTo: string | null
  sheetName: string
} {
  const workbook = XLSX.read(buffer, { type: 'array', cellDates: true })

  // Try to find the right sheet — look for one with "Daily Sales Profitability"
  // or use the first sheet
  let sheetName = workbook.SheetNames[0]
  for (const name of workbook.SheetNames) {
    const ws = workbook.Sheets[name]
    const cellD1 = ws['D1'] || ws['C1'] || ws['E1']
    if (cellD1 && String(cellD1.v || '').includes('Daily Sales Profitability')) {
      sheetName = name
      break
    }
  }

  const ws = workbook.Sheets[sheetName]
  const allRows: unknown[][] = XLSX.utils.sheet_to_json(ws, {
    header: 1,
    raw: false,
    dateNF: 'yyyy-mm-dd',
  })

  // Find the header row — look for a row containing 'Customer:', 'Customer Name', 'Net Sales'
  let headerIdx = -1
  for (let i = 0; i < Math.min(allRows.length, 20); i++) {
    const row = allRows[i]
    if (!row) continue
    const joined = row.map((c) => String(c || '').toLowerCase()).join('|')
    if (joined.includes('customer name') && joined.includes('net sales')) {
      headerIdx = i
      break
    }
  }

  if (headerIdx === -1) {
    throw new Error(
      'Could not find header row. Expected columns: Customer, Customer Name, Net Sales. Make sure this is an Acumatica Daily Sales Profitability export.'
    )
  }

  const headers = (allRows[headerIdx] as string[]).map((h) =>
    String(h || '')
      .toLowerCase()
      .trim()
  )

  // Map column positions
  const colMap = {
    customer_code: headers.findIndex((h) => h === 'customer:' || h === 'customer'),
    customer_name: headers.findIndex((h) => h === 'customer name'),
    customer_group: headers.findIndex((h) => h === 'customer group'),
    doc_date: headers.findIndex((h) => h === 'doc. date' || h === 'doc date'),
    doc_type: headers.findIndex((h) => h === 'doc. type' || h === 'doc type'),
    ref_nbr: headers.findIndex((h) => h === 'ref. nbr.' || h === 'ref nbr'),
    order_type: headers.findIndex((h) => h === 'order type'),
    order_nbr: headers.findIndex((h) => h === 'order nbr.' || h === 'order nbr'),
    net_sales: headers.findIndex((h) => h === 'net sales'),
    cost: headers.findIndex((h) => h === 'cost'),
    margin: headers.findIndex((h) => h === 'margin'),
    margin_pct: headers.findIndex((h) => h === 'margin %' || h === 'margin%'),
  }

  if (colMap.customer_name === -1 || colMap.net_sales === -1) {
    throw new Error(
      `Missing required columns. Found headers: ${headers.filter(Boolean).join(', ')}`
    )
  }

  const rows: ParsedRow[] = []
  let dateFrom: string | null = null
  let dateTo: string | null = null

  for (let i = headerIdx + 1; i < allRows.length; i++) {
    const row = allRows[i] as string[]
    if (!row) continue

    const customerName = String(row[colMap.customer_name] || '').trim()
    if (!customerName) continue

    const netSalesStr = String(row[colMap.net_sales] || '0').replace(/[,$]/g, '')
    const netSales = parseFloat(netSalesStr)
    if (isNaN(netSales)) continue

    // Parse date
    let docDate = ''
    if (colMap.doc_date >= 0 && row[colMap.doc_date]) {
      const raw = row[colMap.doc_date]
      // Try to normalise to YYYY-MM-DD
      if (typeof raw === 'string' && raw.match(/^\d{4}-\d{2}-\d{2}/)) {
        docDate = raw.substring(0, 10)
      } else {
        const d = new Date(raw)
        if (!isNaN(d.getTime())) {
          docDate = d.toISOString().substring(0, 10)
        }
      }
    }

    if (!docDate) continue // Skip rows without dates

    // Track date range
    if (!dateFrom || docDate < dateFrom) dateFrom = docDate
    if (!dateTo || docDate > dateTo) dateTo = docDate

    const costStr = String(row[colMap.cost >= 0 ? colMap.cost : -1] || '0').replace(/[,$]/g, '')
    const marginStr = String(row[colMap.margin >= 0 ? colMap.margin : -1] || '0').replace(
      /[,$]/g,
      ''
    )
    const marginPctStr = String(
      row[colMap.margin_pct >= 0 ? colMap.margin_pct : -1] || ''
    ).replace(/[,%]/g, '')

    rows.push({
      customer_code: colMap.customer_code >= 0 ? String(row[colMap.customer_code] || '').trim() : '',
      customer_name: customerName,
      customer_group: colMap.customer_group >= 0 ? String(row[colMap.customer_group] || '').trim() : '',
      doc_date: docDate,
      doc_type: colMap.doc_type >= 0 ? String(row[colMap.doc_type] || '').trim() : '',
      ref_nbr: colMap.ref_nbr >= 0 ? String(row[colMap.ref_nbr] || '').trim() : '',
      order_type: colMap.order_type >= 0 ? String(row[colMap.order_type] || '').trim() : '',
      order_nbr: colMap.order_nbr >= 0 ? String(row[colMap.order_nbr] || '').trim() : '',
      net_sales: netSales,
      cost: parseFloat(costStr) || 0,
      margin: parseFloat(marginStr) || 0,
      margin_pct: marginPctStr ? parseFloat(marginPctStr) / 100 : null,
    })
  }

  return { rows, dateFrom, dateTo, sheetName }
}

export async function POST(request: NextRequest) {
  try {
    // Auth check
    const supabase = await createClient()
    const {
      data: { user },
    } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    // Check role — admin, manager, cfo, coo only
    const serviceClient = createServiceClient()
    const { data: userData } = await serviceClient
      .from('users')
      .select('id, role')
      .eq('email', user.email)
      .single()

    if (!userData || !['admin', 'manager', 'cfo', 'coo'].includes(userData.role)) {
      return NextResponse.json({ error: 'Insufficient permissions' }, { status: 403 })
    }

    // Parse multipart form data
    const formData = await request.formData()
    const file = formData.get('file') as File | null

    if (!file) {
      return NextResponse.json({ error: 'No file provided' }, { status: 400 })
    }

    if (!file.name.match(/\.(xlsx|xls|csv)$/i)) {
      return NextResponse.json(
        { error: 'Invalid file type. Please upload an Excel file (.xlsx or .xls).' },
        { status: 400 }
      )
    }

    // Parse the Excel file
    const buffer = await file.arrayBuffer()
    let parsed: ReturnType<typeof parseAcumaticaExport>

    try {
      parsed = parseAcumaticaExport(buffer)
    } catch (err) {
      return NextResponse.json(
        { error: `Failed to parse file: ${err instanceof Error ? err.message : 'Unknown error'}` },
        { status: 400 }
      )
    }

    if (parsed.rows.length === 0) {
      return NextResponse.json(
        { error: 'No data rows found in the uploaded file.' },
        { status: 400 }
      )
    }

    // Create upload record
    const { data: upload, error: uploadErr } = await serviceClient
      .from('sales_uploads')
      .insert({
        filename: file.name,
        uploaded_by: userData.id,
        date_range_from: parsed.dateFrom,
        date_range_to: parsed.dateTo,
        total_rows: parsed.rows.length,
        status: 'processing',
      })
      .select('id')
      .single()

    if (uploadErr || !upload) {
      return NextResponse.json(
        { error: `Failed to create upload record: ${uploadErr?.message}` },
        { status: 500 }
      )
    }

    // Fetch all approved display requests for matching
    const { data: displays } = await serviceClient
      .from('display_requests')
      .select('id, store_name, store_code, status')
      .in('status', ['approved', 'validated', 'pending_approval'])

    // Build lookup maps for matching
    const displayByName: Record<string, string> = {}
    const displayByCode: Record<string, string> = {}

    if (displays) {
      for (const d of displays) {
        const nameKey = d.store_name.toLowerCase().trim()
        displayByName[nameKey] = d.id
        if (d.store_code) {
          displayByCode[d.store_code.toLowerCase().trim()] = d.id
        }
      }
    }

    // Match rows to displays and prepare for insert
    let matchedCount = 0
    let unmatchedCount = 0
    const unmatchedCustomers: Record<string, number> = {}

    const rawRows = parsed.rows.map((row) => {
      let matchedRequestId: string | null = null
      let matchMethod = 'unmatched'

      // Try exact name match first
      const nameKey = row.customer_name.toLowerCase().trim()
      if (displayByName[nameKey]) {
        matchedRequestId = displayByName[nameKey]
        matchMethod = 'exact_name'
      }
      // Try store code match
      else if (row.customer_code && displayByCode[row.customer_code.toLowerCase().trim()]) {
        matchedRequestId = displayByCode[row.customer_code.toLowerCase().trim()]
        matchMethod = 'exact_code'
      }
      // Try customer group match (the group name might match a display store name)
      else if (row.customer_group) {
        const groupKey = row.customer_group.toLowerCase().trim()
        if (displayByName[groupKey]) {
          matchedRequestId = displayByName[groupKey]
          matchMethod = 'group'
        }
      }

      if (matchedRequestId) {
        matchedCount++
      } else {
        unmatchedCount++
        unmatchedCustomers[row.customer_name] =
          (unmatchedCustomers[row.customer_name] || 0) + 1
      }

      return {
        upload_id: upload.id,
        customer_code: row.customer_code || null,
        customer_name: row.customer_name,
        customer_group: row.customer_group || null,
        doc_date: row.doc_date,
        doc_type: row.doc_type || null,
        ref_nbr: row.ref_nbr || null,
        order_type: row.order_type || null,
        order_nbr: row.order_nbr || null,
        net_sales: row.net_sales,
        cost: row.cost,
        margin: row.margin,
        margin_pct: row.margin_pct,
        matched_request_id: matchedRequestId,
        match_method: matchMethod,
      }
    })

    // Insert raw rows in batches of 500
    const BATCH_SIZE = 500
    for (let i = 0; i < rawRows.length; i += BATCH_SIZE) {
      const batch = rawRows.slice(i, i + BATCH_SIZE)
      const { error: insertErr } = await serviceClient
        .from('sales_actuals_raw')
        .insert(batch)

      if (insertErr) {
        await serviceClient
          .from('sales_uploads')
          .update({ status: 'failed', error: insertErr.message })
          .eq('id', upload.id)

        return NextResponse.json(
          { error: `Failed to insert rows: ${insertErr.message}` },
          { status: 500 }
        )
      }
    }

    // Refresh monthly actuals from matched rows
    if (matchedCount > 0) {
      await serviceClient.rpc('refresh_monthly_actuals', { p_upload_id: upload.id })
    }

    // Top unmatched customers for the summary
    const topUnmatched = Object.entries(unmatchedCustomers)
      .sort((a, b) => b[1] - a[1])
      .slice(0, 20)
      .map(([name, count]) => ({ name, rows: count }))

    const summary = {
      total_rows: parsed.rows.length,
      matched: matchedCount,
      unmatched: unmatchedCount,
      match_rate: parsed.rows.length > 0 ? Math.round((matchedCount / parsed.rows.length) * 100) : 0,
      date_range: { from: parsed.dateFrom, to: parsed.dateTo },
      sheet_used: parsed.sheetName,
      top_unmatched: topUnmatched,
    }

    // Update upload record
    await serviceClient
      .from('sales_uploads')
      .update({
        status: 'completed',
        matched_rows: matchedCount,
        unmatched_rows: unmatchedCount,
        summary,
      })
      .eq('id', upload.id)

    return NextResponse.json({
      data: {
        upload_id: upload.id,
        ...summary,
      },
    })
  } catch (err) {
    console.error('Upload actuals error:', err)
    return NextResponse.json(
      { error: `Server error: ${err instanceof Error ? err.message : 'Unknown error'}` },
      { status: 500 }
    )
  }
}

// GET: list past uploads
export async function GET() {
  try {
    const supabase = await createClient()
    const {
      data: { user },
    } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const serviceClient = createServiceClient()
    const { data: userData } = await serviceClient
      .from('users')
      .select('id, role')
      .eq('email', user.email)
      .single()

    if (!userData || !['admin', 'manager', 'cfo', 'coo'].includes(userData.role)) {
      return NextResponse.json({ error: 'Insufficient permissions' }, { status: 403 })
    }

    const { data: uploads, error } = await serviceClient
      .from('sales_uploads')
      .select('*')
      .order('uploaded_at', { ascending: false })
      .limit(20)

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 })
    }

    return NextResponse.json({ data: uploads })
  } catch {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
