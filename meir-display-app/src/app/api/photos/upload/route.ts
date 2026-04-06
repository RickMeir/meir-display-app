import { NextRequest, NextResponse } from 'next/server'
import { createClient, createServiceClient } from '@/lib/supabase/server'

const BUCKET = 'display-photos'
const MAX_FILE_SIZE = 10 * 1024 * 1024 // 10MB per photo
const ALLOWED_TYPES = ['image/jpeg', 'image/png', 'image/webp', 'image/heic', 'image/heif']

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

    const serviceClient = createServiceClient()

    // Get user record
    const { data: userData } = await serviceClient
      .from('users')
      .select('id')
      .eq('email', user.email)
      .single()

    if (!userData) {
      return NextResponse.json({ error: 'User not found' }, { status: 404 })
    }

    // Parse multipart form data
    const formData = await request.formData()
    const file = formData.get('file') as File | null
    const requestId = formData.get('request_id') as string | null
    const photoType = formData.get('photo_type') as string | null

    if (!file) {
      return NextResponse.json({ error: 'No file provided' }, { status: 400 })
    }

    if (!photoType || !['location', 'design_rendering', 'current_display'].includes(photoType)) {
      return NextResponse.json(
        { error: 'Invalid photo type. Must be: location, design_rendering, or current_display' },
        { status: 400 }
      )
    }

    // Validate file type
    if (!ALLOWED_TYPES.includes(file.type)) {
      return NextResponse.json(
        { error: 'Invalid file type. Please upload a JPG, PNG, or WebP image.' },
        { status: 400 }
      )
    }

    // Validate file size
    if (file.size > MAX_FILE_SIZE) {
      return NextResponse.json(
        { error: 'File too large. Maximum size is 10MB.' },
        { status: 400 }
      )
    }

    // Generate a unique path: request_id or temp / photo_type / timestamp-filename
    const timestamp = Date.now()
    const safeName = file.name.replace(/[^a-zA-Z0-9._-]/g, '_')
    const folder = requestId || 'pending'
    const storagePath = `${folder}/${photoType}/${timestamp}-${safeName}`

    // Upload to Supabase Storage
    const buffer = await file.arrayBuffer()
    const { data: uploadData, error: uploadError } = await serviceClient
      .storage
      .from(BUCKET)
      .upload(storagePath, buffer, {
        contentType: file.type,
        upsert: false,
      })

    if (uploadError) {
      console.error('Storage upload error:', uploadError)
      return NextResponse.json(
        { error: `Upload failed: ${uploadError.message}` },
        { status: 500 }
      )
    }

    // Get the public URL
    const { data: urlData } = serviceClient
      .storage
      .from(BUCKET)
      .getPublicUrl(storagePath)

    const photoUrl = urlData.publicUrl

    // If we have a request_id, save the metadata to the database
    let photoRecord = null
    if (requestId) {
      const { data, error: dbError } = await serviceClient
        .from('request_photos')
        .insert({
          request_id: requestId,
          photo_url: photoUrl,
          storage_path: storagePath,
          photo_type: photoType,
          filename: file.name,
          file_size: file.size,
          uploaded_by: userData.id,
        })
        .select('id')
        .single()

      if (dbError) {
        console.error('Photo metadata insert error:', dbError)
        // Photo is uploaded but metadata failed — not critical
      } else {
        photoRecord = data
      }
    }

    return NextResponse.json({
      data: {
        photo_url: photoUrl,
        storage_path: storagePath,
        photo_type: photoType,
        filename: file.name,
        file_size: file.size,
        photo_id: photoRecord?.id || null,
      },
    })
  } catch (err) {
    console.error('Photo upload error:', err)
    return NextResponse.json(
      { error: `Server error: ${err instanceof Error ? err.message : 'Unknown error'}` },
      { status: 500 }
    )
  }
}

// DELETE: remove a photo
export async function DELETE(request: NextRequest) {
  try {
    const supabase = await createClient()
    const {
      data: { user },
    } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const { searchParams } = new URL(request.url)
    const photoId = searchParams.get('id')
    const storagePath = searchParams.get('path')

    if (!storagePath) {
      return NextResponse.json({ error: 'Missing storage path' }, { status: 400 })
    }

    const serviceClient = createServiceClient()

    // Delete from storage
    const { error: storageError } = await serviceClient
      .storage
      .from(BUCKET)
      .remove([storagePath])

    if (storageError) {
      console.error('Storage delete error:', storageError)
    }

    // Delete metadata if we have a photo ID
    if (photoId) {
      await serviceClient
        .from('request_photos')
        .delete()
        .eq('id', photoId)
    }

    return NextResponse.json({ data: { deleted: true } })
  } catch (err) {
    console.error('Photo delete error:', err)
    return NextResponse.json(
      { error: `Server error: ${err instanceof Error ? err.message : 'Unknown error'}` },
      { status: 500 }
    )
  }
}
