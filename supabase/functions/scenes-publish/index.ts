import { corsHeaders, generateAccessCode } from '../_shared/util.ts';
import { verifyUser, authorizeRole, getAdminClient } from '../_shared/auth.ts';

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders });
  
  try {
    const user = await verifyUser(req);
    authorizeRole(user.role, 'instructor');
    const { sceneId, expiresAt } = await req.json();
    const supabaseAdmin = getAdminClient();

    const { data: scene } = await supabaseAdmin.from('scene').select('*').eq('scene_id', sceneId).single();
    if (scene.scene_type !== 'level') return new Response('Only levels can be published', { status: 403 });

    const accessCode = generateAccessCode();
    
    const { error: accessErr } = await supabaseAdmin.from('scene_access').insert({
      scene_id: sceneId,
      access_code: accessCode,
      expires_at: expiresAt
    });
    console.log(accessErr);
    if (accessErr) throw accessErr;

    await supabaseAdmin.from('scene').update({ is_published: true }).eq('scene_id', sceneId);

    return new Response(JSON.stringify([{
      sceneId,
      accessCode,
      qrPayload: accessCode,
      isPublished: true
    }]), { headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
  } catch (err) {
    return new Response(JSON.stringify({ error: (err instanceof Error) ? err.message : "An unknown error occurred." }), { status: 500, headers: { ...corsHeaders } });
  }
});