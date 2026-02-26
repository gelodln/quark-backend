import { corsHeaders, camelToSnake } from '../_shared/util.ts';
import { verifyUser, authorizeRole, getAdminClient } from '../_shared/auth.ts';

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders });
  
  try {
    const user = await verifyUser(req);
    authorizeRole(user.role, 'instructor');
    const { sceneId, criteria } = await req.json();
    const supabaseAdmin = getAdminClient();

    // Verify ownership
    const { data: scene } = await supabaseAdmin.from('scene').select('owner_id').eq('scene_id', sceneId).single();
    if (scene?.owner_id !== user.id) return new Response('Forbidden', { status: 403 });

    // Transactional Clear and Insert
    await supabaseAdmin.from('scene_criterion').delete().eq('scene_id', sceneId);
    
    const dbCriteria = criteria.map((c: any) => camelToSnake({ ...c, sceneId }));
    const { error } = await supabaseAdmin.from('scene_criterion').insert(dbCriteria);
    console.log(error);
    if (error) throw error;

    return new Response(JSON.stringify([{ sceneId, criteriaCount: criteria.length }]), { headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
  } catch (err) {
    return new Response(JSON.stringify({ error: (err instanceof Error) ? err.message : "An unknown error occurred." }), { status: 400, headers: { ...corsHeaders } });
  }
});