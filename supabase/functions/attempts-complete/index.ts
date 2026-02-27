import { corsHeaders } from '../_shared/util.ts';
import { verifyUser, getAdminClient } from '../_shared/auth.ts';

Deno.serve(async (req) => {
  // CORS Stuff
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders });

  try {
    // Verify User Token
    const user = await verifyUser(req);

    // Parse Request Body
    const { attemptId, success, score, completionTimeSeconds } = await req.json();

    // Get Admin Client for Admin Privileges
    const supabaseAdmin = getAdminClient();

    // Get Attempt Data from Database
    const { data: attempt } = await supabaseAdmin.from('attempt').select('finished_at').eq('attempt_id', attemptId).single();
    if (attempt?.finished_at) return new Response('Already completed', { status: 409, headers: corsHeaders });

    // Update Attempt to Completed
    const { data, error } = await supabaseAdmin
      .from('attempt')
      .update({ 
        success, 
        score, 
        finished_at: new Date().toISOString() 
      })
      .eq('attempt_id', attemptId)
      .eq('student_id', user.id)
      .select('attempt_id, success, score, finished_at')
      .single();

    if (error) throw error;

    // Success Response
    return new Response(JSON.stringify([{
      ...data,
      completionTimeSeconds,
      completedAt: data.finished_at
    }]), { headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
  } catch (err) {
    return new Response((err instanceof Error) ? err.message : "An unknown error occurred.", { status: 500, headers: corsHeaders });
  }
});