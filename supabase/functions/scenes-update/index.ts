import { corsHeaders } from '../_shared/util.ts';
import { verifyUser, getAdminClient } from '../_shared/auth.ts';

Deno.serve(async (req) => {
  // CORS Stuff
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders });
  
  try {
    // Verify User Token
    const user = await verifyUser(req);

    // Parse Request Body
    const { sceneId, sceneData } = await req.json();

    // Get Admin Client for Admin Privileges
    const supabaseAdmin = getAdminClient();

    // Update Scene Data to Database
    const { data, error } = await supabaseAdmin
      .from('scene')
      .update({ scene_data: sceneData })
      .eq('scene_id', sceneId)
      .eq('owner_id', user.id)
      .select('scene_id, updated_at')
      .single();

    if (error || !data) return new Response(JSON.stringify({ error: 'Not found or Unauthorized' }), { status: 403, headers: { ...corsHeaders } });

    // Success Response
    return new Response(JSON.stringify([{ sceneId: data.scene_id, updatedAt: data.updated_at }]), { headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
  } catch (err) {
    return new Response(JSON.stringify({ error: (err instanceof Error) ? err.message : "An unknown error occurred." }), { status: 500, headers: { ...corsHeaders } });
  }
});