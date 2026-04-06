import Link from 'next/link';
import { createClient, createServiceClient } from '@/lib/supabase/server';
import { signOutAction } from '@/lib/auth/actions';

export default async function Nav() {
  const supabase = await createClient();

  // Get current user
  const {
    data: { user },
  } = await supabase.auth.getUser();

  // Get user role, name, and ID
  let userRole = '';
  let userName = '';
  let userId = '';

  if (user?.email) {
    const { data } = await supabase
      .from('users')
      .select('id, name, role')
      .eq('email', user.email)
      .single();

    if (data) {
      userId = data.id || '';
      userRole = data.role || '';
      userName = data.name || user.email;
    }
  }

  // Fetch pending task count for badge
  let pendingTaskCount = 0;
  if (userId) {
    const serviceClient = createServiceClient();
    const { count } = await serviceClient
      .from('user_tasks')
      .select('*', { count: 'exact', head: true })
      .eq('assigned_to', userId)
      .eq('status', 'pending');

    pendingTaskCount = count || 0;
  }

  const showUploadActuals = ['admin', 'manager', 'cfo', 'coo'].includes(userRole);

  return (
    <nav className="bg-gray-900 text-white">
      <div className="max-w-7xl mx-auto px-6 py-4">
        <div className="flex items-center justify-between">
          {/* Left side: Brand and links */}
          <div className="flex items-center gap-8">
            <Link href="/dashboard" className="text-xl font-bold hover:opacity-90">
              Meir Displays
            </Link>

            <div className="flex items-center gap-6">
              <Link href="/dashboard" className="hover:text-gray-300 transition">
                Home
              </Link>
              <Link href="/requests/new" className="hover:text-gray-300 transition">
                New Display Request
              </Link>
              <Link href="/requests" className="hover:text-gray-300 transition">
                Display Register
              </Link>
              <Link href="/tasks" className="hover:text-gray-300 transition flex items-center gap-1.5">
                To Do
                {pendingTaskCount > 0 && (
                  <span className="inline-flex items-center justify-center min-w-[20px] h-5 px-1.5 text-xs font-bold bg-red-500 text-white rounded-full">
                    {pendingTaskCount > 99 ? '99+' : pendingTaskCount}
                  </span>
                )}
              </Link>

              {showUploadActuals && (
                <Link href="/actuals/upload" className="hover:text-gray-300 transition">
                  Upload Actuals
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
                  className="px-4 py-2 bg-red-700 hover:bg-red-600 rounded transition text-sm font-medium"
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
