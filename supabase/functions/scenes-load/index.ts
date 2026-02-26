import { corsHeaders } from '../_shared/util.ts';
import { verifyUser, getAdminClient } from '../_shared/auth.ts';

// URL: functions/v1/scenes-load/[scene_id]
Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders });

  try {
    const user = await verifyUser(req);
    const url = new URL(req.url);
    const sceneId = url.pathname.split('/').pop();
    const supabaseAdmin = getAdminClient();

    const { data, error } = await supabaseAdmin
      .from('scene')
      .select('scene_id, scene_type, topic_id, scene_data, updated_at')
      .eq('scene_id', sceneId)
      .eq('owner_id', user.id)
      .single();

    if (error || !data) return new Response('Not Found', { status: 404, headers: corsHeaders });

    return new Response(JSON.stringify([{
      sceneId: data.scene_id,
      sceneType: data.scene_type,
      topicId: data.topic_id,
      sceneData: data.scene_data,
      updatedAt: data.updated_at
    }]), { headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
  } catch (err) {
    return new Response((err instanceof Error) ? err.message : "An unknown error occurred.", { status: 500, headers: corsHeaders });
  }
});