import { corsHeaders } from '../_shared/util.ts';
import { getAdminClient } from '../_shared/auth.ts';

// URL: functions/v1/scenes-load-by-code?accessCode=[access-code]
Deno.serve(async (req) => {
  // CORS Stuff
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders });

  // Parse URL to get Access Code
  const url = new URL(req.url);
  const accessCode = url.searchParams.get('accessCode');
    
  // Get Admin Client for Admin Privileges
  const supabaseAdmin = getAdminClient();

  // Get Scene Data from Database
  const { data, error } = await supabaseAdmin
    .from('scene_access')
    .select(`
      expires_at,
      scene (
        scene_id, scene_type, title, description, scene_data,
        topic (topic_name),
        scene_criterion (criterion_type, target_object_id, secondary_object_id)
      )
    `)
    .eq('access_code', accessCode)
    .single();
  
  if (error || !data) return new Response('Not Found', { status: 404, headers: corsHeaders });
  if (data.expires_at && new Date(data.expires_at) < new Date()) return new Response('Expired', { status: 403, headers: corsHeaders });
 
  // Success Response
  const scene = data.scene as any;
  const result = [{
    sceneId: scene.scene_id,
    sceneType: scene.scene_type,
    topic: scene.topic.topic_name,
    title: scene.title,
    description: scene.description,
    sceneData: scene.scene_data,
    criteria: scene.scene_criterion.map((c: any) => ({
      criterionType: c.criterion_type,
      targetObjectId: c.target_object_id,
      secondaryObjectId: c.secondary_object_id
    }))
  }];

  return new Response(JSON.stringify(result), { headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
});