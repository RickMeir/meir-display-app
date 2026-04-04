import { NextRequest, NextResponse } from 'next/server';
import { createClient, createServiceClient } from '@/lib/supabase/server';
import { TIER_APPROVER } from '@/lib/calculations';
import {
  sendDesignReviewEmail,
  sendApprovalRequestEmail,
  sendQueryEmail,
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

    // Verify user is a validator or admin
    const { data: userData, error: userError } = await supabase
      .from('users')
      .select('role, email')
      .eq('id', user.id)
      .single();

    if (userError || !userData) {
      return NextResponse.json(
        { error: 'Failed to fetch user' },
        { status: 500 }
      );
    }

    const role = userData.role;
    if (role !== 'validator' && role !== 'admin') {
      return NextResponse.json(
        { error: 'Only validators and admins can validate requests' },
        { status: 403 }
      );
    }

    // Parse request body
    const body = await request.json();
    const { action, note } = body;

    if (!action || !['validate', 'query'].includes(action)) {
      return NextResponse.json(
        { error: 'Invalid action. Must be "validate" or "query"' },
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

    const serviceSupabase = await createServiceClient();
    let updateData: any = {};

    if (action === 'validate') {
      // Determine routed_to based on approval_tier
      let routedToEmail: string | null = null;

      if (displayRequest.approval_tier && TIER_APPROVER[displayRequest.approval_tier]) {
        routedToEmail = TIER_APPROVER[displayRequest.approval_tier];

        // Look up the approver user id
        const { data: approverData } = await supabase
          .from('users')
          .select('id')
          .eq('email', routedToEmail)
          .single();

        if (approverData) {
          updateData.routed_to = approverData.id;
        }
      }

      updateData.status = 'pending_approval';
      updateData.validated_by = user.id;
      updateData.validated_at = new Date().toISOString();

      // Update the request
      const { data: updatedRequest, error: updateError } = await serviceSupabase
        .from('display_requests')
        .update(updateData)
        .eq('id', id)
        .select()
        .single();

      if (updateError) {
        console.error('Error updating request:', updateError);
        return NextResponse.json(
          { error: 'Failed to validate request' },
          { status: 500 }
        );
      }

      // Create audit log entry
      const { error: auditError } = await serviceSupabase
        .from('audit_log')
        .insert([
          {
            request_id: id,
            action: 'validated',
            performed_by: user.id,
            performed_at: new Date().toISOString(),
            details: `Request validated and routed to ${routedToEmail || 'unknown approver'}`,
          },
        ]);

      if (auditError) {
        console.error('Error creating audit log:', auditError);
      }

      // Send emails
      try {
        await sendDesignReviewEmail(updatedRequest);
        if (routedToEmail) {
          await sendApprovalRequestEmail(updatedRequest, routedToEmail);
        }
      } catch (emailError) {
        console.error('Error sending validation emails:', emailError);
      }

      return NextResponse.json(updatedRequest, { status: 200 });
    } else if (action === 'query') {
      // Query action
      updateData.status = 'queried';
      updateData.validation_note = note || null;

      const { data: updatedRequest, error: updateError } = await serviceSupabase
        .from('display_requests')
        .update(updateData)
        .eq('id', id)
        .select()
        .single();

      if (updateError) {
        console.error('Error updating request:', updateError);
        return NextResponse.json(
          { error: 'Failed to query request' },
          { status: 500 }
        );
      }

      // Create audit log entry
      const { error: auditError } = await serviceSupabase
        .from('audit_log')
        .insert([
          {
            request_id: id,
            action: 'queried',
            performed_by: user.id,
            performed_at: new Date().toISOString(),
            details: `Request queried: ${note || 'No note provided'}`,
          },
        ]);

      if (auditError) {
        console.error('Error creating audit log:', auditError);
      }

      // Send query email
      try {
        await sendQueryEmail(updatedRequest, note);
      } catch (emailError) {
        console.error('Error sending query email:', emailError);
      }

      return NextResponse.json(updatedRequest, { status: 200 });
    }
  } catch (error) {
    console.error('POST /api/requests/[id]/validate error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
