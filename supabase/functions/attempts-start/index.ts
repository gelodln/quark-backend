import { corsHeaders } from '../_shared/util.ts';
import { verifyUser, getAdminClient } from '../_shared/auth.ts';

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders });

  try {
    const user = await verifyUser(req);
    const { sceneId } = await req.json();
    const supabaseAdmin = getAdminClient();

    const { data, error } = await supabaseAdmin
      .from('attempt')
      .insert({ scene_id: sceneId, student_id: user.id, started_at: new Date().toISOString() })
      .select('attempt_id, started_at')
      .single();

    if (error) throw error;
    return new Response(JSON.stringify([data]), { headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
  } catch (err) {
    return new Response((err instanceof Error) ? err.message : "An unknown error occurred.", { status: 400, headers: corsHeaders });
  }
});