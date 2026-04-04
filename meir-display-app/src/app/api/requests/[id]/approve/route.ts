import { NextRequest, NextResponse } from 'next/server';
import { createClient, createServiceClient } from '@/lib/supabase/server';
import {
  sendCSProcessingEmail,
  sendApprovalConfirmationEmail,
  sendRejectionEmail,
  sendOverrideAlertEmail,
} from '@/lib/email';

export async function POST(
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

    // Parse request body
    const body = await request.json();
    const { action, note } = body;

    if (!action || !['approve', 'reject'].includes(action)) {
      return NextResponse.json(
        { error: 'Invalid action. Must be "approve" or "reject"' },
        { status: 400 }
      );
    }

    const { id } = params;

    // Fetch the request
    const { data: displayRequest, error: fetchError } = await supabase
      .from('display_requests')
      .select('*')
      .eq('id', id)
      .single();

    if (fetchError || !displayRequest) {
      return NextResponse.json(
        { error: 'Request not found' },
        { status: 404 }
      );
    }

    // Check authorization: user must have role matching approval_tier or be admin
    if (role !== 'admin' && role !== displayRequest.approval_tier) {
      return NextResponse.json(
        { error: 'You are not authorized to approve this request' },
        { status: 403 }
      );
    }

    const serviceSupabase = await createServiceClient();
    let updateData: any = {
      approval_note: note || null,
    };

    if (action === 'approve') {
      updateData.status = 'approved';
      updateData.approved_by = user.id;
      updateData.approved_at = new Date().toISOString();

      // Check if this is an override
      if (displayRequest.profitability_flag === 'review') {
        updateData.was_override = true;
      }

      const { data: updatedRequest, error: updateError } = await serviceSupabase
        .from('display_requests')
        .update(updateData)
        .eq('id', id)
        .select()
        .single();

      if (updateError) {
        console.error('Error updating request:', updateError);
        return NextResponse.json(
          { error: 'Failed to approve request' },
          { status: 500 }
        );
      }

      // Create audit log entry
      const { error: auditError } = await serviceSupabase
        .from('audit_log')
        .insert([
          {
            request_id: id,
            action: 'approved',
            performed_by: user.id,
            performed_at: new Date().toISOString(),
            details: `Request approved by ${role}. Note: ${note || 'None'}`,
          },
        ]);

      if (auditError) {
        console.error('Error creating audit log:', auditError);
      }

      // Send emails
      try {
        await sendCSProcessingEmail(updatedRequest);
        await sendApprovalConfirmationEmail(updatedRequest);

        // If override, send discrete alert (approver does not know)
        if (updatedRequest.was_override) {
          await sendOverrideAlertEmail(updatedRequest);
        }
      } catch (emailError) {
        console.error('Error sending approval emails:', emailError);
      }

      return NextResponse.json(updatedRequest, { status: 200 });
    } else if (action === 'reject') {
      updateData.status = 'rejected';

      const { data: updatedRequest, error: updateError } = await serviceSupabase
        .from('display_requests')
        .update(updateData)
        .eq('id', id)
        .select()
        .single();

      if (updateError) {
        console.error('Error updating request:', updateError);
        return NextResponse.json(
          { error: 'Failed to reject request' },
          { status: 500 }
        );
      }

      // Create audit log entry
      const { error: auditError } = await serviceSupabase
        .from('audit_log')
        .insert([
          {
            request_id: id,
            action: 'rejected',
            performed_by: user.id,
            performed_at: new Date().toISOString(),
            details: `Request rejected by ${role}. Note: ${note || 'None'}`,
          },
        ]);

      if (auditError) {
        console.error('Error creating audit log:', auditError);
      }

      // Send rejection email
      try {
        await sendRejectionEmail(updatedRequest, note);
      } catch (emailError) {
        console.error('Error sending rejection email:', emailError);
      }

      return NextResponse.json(updatedRequest, { status: 200 });
    }
  } catch (error) {
    console.error('POST /api/requests/[id]/approve error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
