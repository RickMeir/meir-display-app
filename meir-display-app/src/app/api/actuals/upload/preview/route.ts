import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'
import * as XLSX from 'xlsx'

// Lightweight preview endpoint — parses the file and returns a summary
// without writing anything to the database. The UI shows this to the user
// for confirmation before calling the main POST /api/actuals/upload.

interface ParsedRow {
  customer_code: string
  customer_name: string
  customer_group: string
  doc_date: string
  net_sales: number
  cost: number
  margin: number
}

function parseForPreview(buffer: ArrayBuffer): {
  rows: ParsedRow[]
  dateFrom: string | null
  dateTo: string | null
  sheetName: string
} {
  const workbook = XLSX.read(buffer, { type: 'array', cellDates: true })

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
    String(h || '').toLowerCase().trim()
  )

  const colMap = {
    customer_code: headers.findIndex((h) => h === 'customer:' || h === 'customer'),
    customer_name: headers.findIndex((h) => h === 'customer name'),
    customer_group: headers.findIndex((h) => h === 'customer group'),
    doc_date: headers.findIndex((h) => h === 'doc. date' || h === 'doc date'),
    net_sales: headers.findIndex((h) => h === 'net sales'),
    cost: headers.findIndex((h) => h === 'cost'),
    margin: headers.findIndex((h) => h === 'margin'),
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

    let docDate = ''
    if (colMap.doc_date >= 0 && row[colMap.doc_date]) {
      const raw = row[colMap.doc_date]
      if (typeof raw === 'string' && raw.match(/^\d{4}-\d{2}-\d{2}/)) {
        docDate = raw.substring(0, 10)
      } else {
        const d = new Date(raw)
        if (!isNaN(d.getTime())) {
          docDate = d.toISOString().substring(0, 10)
        }
      }
    }

    if (!docDate) continue

    if (!dateFrom || docDate < dateFrom) dateFrom = docDate
    if (!dateTo || docDate > dateTo) dateTo = docDate

    const costStr = String(row[colMap.cost >= 0 ? colMap.cost : -1] || '0').replace(/[,$]/g, '')
    const marginStr = String(row[colMap.margin >= 0 ? colMap.margin : -1] || '0').replace(/[,$]/g, '')

    rows.push({
      customer_code: colMap.customer_code >= 0 ? String(row[colMap.customer_code] || '').trim() : '',
      customer_name: customerName,
      customer_group: colMap.customer_group >= 0 ? String(row[colMap.customer_group] || '').trim() : '',
      doc_date: docDate,
      net_sales: netSales,
      cost: parseFloat(costStr) || 0,
      margin: parseFloat(marginStr) || 0,
    })
  }

  return { rows, dateFrom, dateTo, sheetName }
}

export async function POST(request: NextRequest) {
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

    const buffer = await file.arrayBuffer()
    let parsed: ReturnType<typeof parseForPreview>

    try {
      parsed = parseForPreview(buffer)
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

    // Check for duplicate uploads
    const { data: existing } = await serviceClient
      .from('sales_uploads')
      .select('id, filename, date_range_from, date_range_to, status')
      .eq('filename', file.name)
      .eq('status', 'completed')

    const duplicateWarning =
      existing && existing.length > 0
        ? `A file named "${file.name}" was already uploaded previously. Uploading again will create duplicate raw data. Consider deleting the older upload first.`
        : null

    // Fetch display requests and aliases for matching preview
    const { data: displays } = await serviceClient
      .from('display_requests')
      .select('id, store_name, store_code, status')
      .in('status', ['approved', 'validated', 'pending_approval'])

    const { data: aliases } = await serviceClient
      .from('customer_aliases')
      .select('acumatica_name, display_request_id')

    const displayByName: Record<string, string> = {}
    const displayByCode: Record<string, string> = {}
    const displayByAlias: Record<string, string> = {}

    if (displays) {
      for (const d of displays) {
        displayByName[d.store_name.toLowerCase().trim()] = d.id
        if (d.store_code) {
          displayByCode[d.store_code.toLowerCase().trim()] = d.id
        }
      }
    }

    if (aliases) {
      for (const a of aliases) {
        displayByAlias[a.acumatica_name.toLowerCase().trim()] = a.display_request_id
      }
    }

    let matchedCount = 0
    let unmatchedCount = 0
    const unmatchedCustomers: Record<string, number> = {}
    let totalNetSales = 0
    let totalCost = 0
    let totalMargin = 0

    // Aggregate by customer for the preview table
    const customerSummary: Record<string, { rows: number; net_sales: number; matched: boolean; match_method: string }> = {}

    for (const row of parsed.rows) {
      let matched = false
      let matchMethod = 'unmatched'
      const nameKey = row.customer_name.toLowerCase().trim()

      if (displayByName[nameKey]) {
        matched = true
        matchMethod = 'exact_name'
      } else if (displayByAlias[nameKey]) {
        matched = true
        matchMethod = 'alias'
      } else if (row.customer_code && displayByCode[row.customer_code.toLowerCase().trim()]) {
        matched = true
        matchMethod = 'exact_code'
      } else if (row.customer_group) {
        const groupKey = row.customer_group.toLowerCase().trim()
        if (displayByName[groupKey]) {
          matched = true
          matchMethod = 'group'
        }
      }

      if (matched) {
        matchedCount++
      } else {
        unmatchedCount++
        unmatchedCustomers[row.customer_name] = (unmatchedCustomers[row.customer_name] || 0) + 1
      }

      totalNetSales += row.net_sales
      totalCost += row.cost
      totalMargin += row.margin

      if (!customerSummary[row.customer_name]) {
        customerSummary[row.customer_name] = { rows: 0, net_sales: 0, matched, match_method: matchMethod }
      }
      customerSummary[row.customer_name].rows++
      customerSummary[row.customer_name].net_sales += row.net_sales
    }

    // Top customers by revenue for the preview
    const topCustomers = Object.entries(customerSummary)
      .sort((a, b) => b[1].net_sales - a[1].net_sales)
      .slice(0, 30)
      .map(([name, data]) => ({
        name,
        rows: data.rows,
        net_sales: Math.round(data.net_sales * 100) / 100,
        matched: data.matched,
        match_method: data.match_method,
      }))

    const topUnmatched = Object.entries(unmatchedCustomers)
      .sort((a, b) => b[1] - a[1])
      .slice(0, 20)
      .map(([name, count]) => ({ name, rows: count }))

    return NextResponse.json({
      data: {
        filename: file.name,
        total_rows: parsed.rows.length,
        matched: matchedCount,
        unmatched: unmatchedCount,
        match_rate: parsed.rows.length > 0 ? Math.round((matchedCount / parsed.rows.length) * 100) : 0,
        date_range: { from: parsed.dateFrom, to: parsed.dateTo },
        sheet_used: parsed.sheetName,
        total_net_sales: Math.round(totalNetSales * 100) / 100,
        total_cost: Math.round(totalCost * 100) / 100,
        total_margin: Math.round(totalMargin * 100) / 100,
        top_customers: topCustomers,
        top_unmatched: topUnmatched,
        duplicate_warning: duplicateWarning,
      },
    })
  } catch (err) {
    console.error('Upload preview error:', err)
    return NextResponse.json(
      { error: `Server error: ${err instanceof Error ? err.message : 'Unknown error'}` },
      { status: 500 }
    )
  }
}
