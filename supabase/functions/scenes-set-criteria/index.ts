import { corsHeaders, camelToSnake } from '../_shared/util.ts';
import { verifyUser, authorizeRole, getAdminClient } from '../_shared/auth.ts';

Deno.serve(async (req) => {
  // CORS Stuff
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders });
  
  try {
    // Verify User Token
    const user = await verifyUser(req);

    // Verify User is an Instructor
    authorizeRole(user.role, 'instructor');

    // Parse Request Body
    const { sceneId, criteria } = await req.json();

    // Get Admin Client for Admin Privileges
    const supabaseAdmin = getAdminClient();

    // Verify Scene ownership
    const { data: scene } = await supabaseAdmin.from('scene').select('owner_id').eq('scene_id', sceneId).single();
    if (scene?.owner_id !== user.id) return new Response('Forbidden', { status: 403 });

    // Clear previous Scene Criteria
    await supabaseAdmin.from('scene_criterion').delete().eq('scene_id', sceneId);
    
    // Insert Scene Criteria to Database
    const dbCriteria = criteria.map((c: any) => camelToSnake({ ...c, sceneId }));
    const { error } = await supabaseAdmin.from('scene_criterion').insert(dbCriteria);
    
    if (error) throw error;

    // Success Response
    return new Response(JSON.stringify([{ sceneId, criteriaCount: criteria.length }]), { headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
  } catch (err) {
    return new Response(JSON.stringify({ error: (err instanceof Error) ? err.message : "An unknown error occurred." }), { status: 400, headers: { ...corsHeaders } });
  }
});