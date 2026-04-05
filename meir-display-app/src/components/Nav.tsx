import Link from 'next/link';
import { createClient } from '@/lib/supabase/server';
import { signOutAction } from '@/lib/auth/actions';

export default async function Nav() {
  const supabase = await createClient();

  // Get current user
  const {
    data: { user },
  } = await supabase.auth.getUser();

  // Get user role and name
  let userRole = '';
  let userName = '';

  if (user?.email) {
    const { data } = await supabase
      .from('users')
      .select('name, role')
      .eq('email', user.email)
      .single();

    if (data) {
      userRole = data.role || '';
      userName = data.name || user.email;
    }
  }

  const showNewRequest = ['rep', 'admin'].includes(userRole);
  const showPendingValidation = ['validator', 'admin'].includes(userRole);
  const showPendingApproval = ['manager', 'cfo', 'coo', 'admin'].includes(userRole);

  return (
    <nav className="bg-meir-800 text-white">
      <div className="max-w-7xl mx-auto px-6 py-4">
        <div className="flex items-center justify-between">
          {/* Left side: Brand and links */}
          <div className="flex items-center gap-8">
            <Link href="/dashboard" className="text-xl font-bold hover:opacity-90">
              Meir Display Management
            </Link>

            <div className="flex items-center gap-6">
              <Link href="/dashboard" className="hover:text-gray-300 transition">
                Dashboard
              </Link>
              <Link href="/requests" className="hover:text-gray-300 transition">
                My Requests
              </Link>

              {showNewRequest && (
                <Link href="/requests/new" className="hover:text-gray-300 transition">
                  New Request
                </Link>
              )}

              {showPendingValidation && (
                <Link href="/requests?status=submitted" className="hover:text-gray-300 transition">
                  Pending Validation
                </Link>
              )}

              {showPendingApproval && (
                <Link href="/requests?status=pending_approval" className="hover:text-gray-300 transition">
                  Pending Approval
                </Link>
              )}
            </div>
          </div>

          {/* Right side: User name and sign out */}
          {user && (
            <div className="flex items-center gap-4">
              <span className="text-sm">{userName}</span>
              <form action={signOutAction}>
                <button
                  type="submit"
                  className="px-4 py-2 bg-meir-700 hover:bg-meir-600 rounded transition text-sm font-medium"
                >
                  Sign out
                </button>
              </form>
            </div>
          )}
        </div>
      </div>
    </nav>
  );
}
