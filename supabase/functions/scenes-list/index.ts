import { corsHeaders } from '../_shared/util.ts';
import { verifyUser, getAdminClient } from '../_shared/auth.ts';

Deno.serve(async (req) => {
  // CORS Stuff
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    // Get Admin Client for Admin Privileges
    const supabaseClient = getAdminClient();

    // Verify User Token
    const user = await verifyUser(req);

    // Get Scenes from Database
    const { data, error } = await supabaseClient
      .from('user')
      .select(`
        user_id,
        scene (
          scene_id,
          title,
          topic_id,
          scene_type,
          is_published,
          updated_at
        )
      `)
      .eq('user_id', user.id)
      .single()

    if (error) throw error

    // Success Response
    return new Response(JSON.stringify(data.scene), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })

  } catch (err) {
    return new Response((err instanceof Error) ? err.message : "An unknown error occurred.", { status: 500, headers: corsHeaders });
  }
})