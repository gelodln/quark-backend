import { corsHeaders } from '../_shared/util.ts';
import { verifyUser, getAdminClient } from '../_shared/auth.ts';

Deno.serve(async (req) => {
  // CORS Stuff
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders });

  try {
    // Verify User Token
    const user = await verifyUser(req);

    // Parse Request Body
    const { sceneId } = await req.json();

    // Get Admin Client for Admin Privileges
    const supabaseAdmin = getAdminClient();

    // Insert Attempt Data to Database
    const { data, error } = await supabaseAdmin
      .from('attempt')
      .insert({ scene_id: sceneId, student_id: user.id, started_at: new Date().toISOString() })
      .select('attempt_id, started_at')
      .single();

    if (error) throw error;

    // Success Response
    return new Response(JSON.stringify([data]), { headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
  } catch (err) {
    return new Response((err instanceof Error) ? err.message : "An unknown error occurred.", { status: 400, headers: corsHeaders });
  }
});