import { corsHeaders, camelToSnake } from '../_shared/util.ts';
import { verifyUser, authorizeRole, getAdminClient } from '../_shared/auth.ts';

Deno.serve(async (req) => {
  // CORS Stuff
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders });
  
  try {
    // Verify User Token
    const user = await verifyUser(req);

    // Parse Request Body
    const body = await req.json();
    
    if (body.sceneType === 'level') {
      authorizeRole(user.role, 'instructor');
    }

    // Get Admin Client for Admin Privileges
    const supabaseAdmin = getAdminClient();
    const dbPayload = camelToSnake({ ...body, ownerId: user.id }); // Utility function

    // Insert Scene to Database
    const { data, error } = await supabaseAdmin
      .from('scene')
      .insert([dbPayload])
      .select('scene_id, scene_type, topic_id, created_at')
      .single();

    if (error) throw error;

    // Success Response
    const response = [{
      sceneId: data.scene_id,
      sceneType: data.scene_type,
      topicId: data.topic_id,
      createdAt: data.created_at
    }];
    return new Response(JSON.stringify(response), { status: 201, headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
  } catch (err) {
    return new Response(JSON.stringify({ error: (err instanceof Error) ? err.message : "An unknown error occurred." }), { status: 400, headers: { ...corsHeaders } }) ;
  }
});