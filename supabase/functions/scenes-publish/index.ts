import { corsHeaders, generateAccessCode } from '../_shared/util.ts';
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
    const { sceneId, expiresAt } = await req.json();

    // Get Admin Client for Admin Privileges
    const supabaseAdmin = getAdminClient();

    // Get Scene from Database
    const { data: scene } = await supabaseAdmin.from('scene').select('*').eq('scene_id', sceneId).single();
    if (scene.scene_type !== 'level') return new Response('Only levels can be published', { status: 403 });

    // Generate an access code for Scene
    const accessCode = generateAccessCode();
    
    // Insert Scene Access Data to Database
    const { error: accessErr } = await supabaseAdmin.from('scene_access').insert({
      scene_id: sceneId,
      access_code: accessCode,
      expires_at: expiresAt
    });
    
    if (accessErr) throw accessErr;

    // Update Scene Data as Published
    await supabaseAdmin.from('scene').update({ is_published: true }).eq('scene_id', sceneId);

    // Success Response
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