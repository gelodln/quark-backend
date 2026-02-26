import { corsHeaders } from '../_shared/util.ts';
import { verifyUser, getAdminClient } from '../_shared/auth.ts';

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders });

  try {
    const user = await verifyUser(req);
    const { attemptId, success, score, completionTimeSeconds } = await req.json();
    const supabaseAdmin = getAdminClient();
    const { data: attempt } = await supabaseAdmin.from('attempt').select('finished_at').eq('attempt_id', attemptId).single();
    if (attempt?.finished_at) return new Response('Already completed', { status: 409, headers: corsHeaders });

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

    return new Response(JSON.stringify([{
      ...data,
      completionTimeSeconds,
      completedAt: data.finished_at
    }]), { headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
  } catch (err) {
    return new Response((err instanceof Error) ? err.message : "An unknown error occurred.", { status: 500, headers: corsHeaders });
  }
});