import { corsHeaders } from '../_shared/util.ts'
import { getAdminClient } from '../_shared/auth.ts';

Deno.serve(async (req) => {
  // CORS Stuff
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders });

  // Get Admin Client for Admin Privileges
  const supabaseAdmin = getAdminClient()
  let createdAuthUserId: string | null = null

  try {
    // Parse Request Body
    const { email, password, roleName } = await req.json()

    if (!email || !password || !roleName) {
      throw new Error('MISSING_FIELDS')
    }

    // Create User in Supabase Auth
    const { data: authData, error: authError } = await supabaseAdmin.auth.admin.createUser({
      email,
      password,
      user_metadata: { role: roleName.toLowerCase() },
      email_confirm: true,
    })

    if (authError) {
      if (authError.message.includes('already registered')) throw new Error('USER_EXISTS')
      throw authError
    }

    createdAuthUserId = authData.user.id

    // Verify Role
    const { data: roleData, error: roleError } = await supabaseAdmin
      .from('role')
      .select('role_id')
      .eq('role_name', roleName)
      .single()

    if (roleError || !roleData) {
      throw new Error('INVALID_ROLE')
    }

    // Insert User to Database
    const { error: profileError } = await supabaseAdmin
      .from('user')
      .insert({
        user_id: authData.user.id, // UUID from Auth
        role_id: roleData.role_id, // int from role table
        email: email,
      })

    if (profileError) throw profileError

    // Success Response
    return new Response(
      JSON.stringify({ user_id: authData.user.id }),
      { 
        status: 201, 
        headers: { ...corsHeaders, 'Content-Type': 'application/json' } 
      }
    )

  } catch (err) {
    // Rollback Supabase Auth User if Database insert fails
    if (createdAuthUserId) {
      await supabaseAdmin.auth.admin.deleteUser(createdAuthUserId)
    }

    const errorMap: Record<string, { status: number; message: string }> = {
      MISSING_FIELDS: { status: 400, message: 'Email, password, and roleName are required.' },
      USER_EXISTS: { status: 400, message: 'A user with this email is already registered.' },
      INVALID_ROLE: { status: 400, message: 'The specified roleName is invalid.' },
    }

    const { status, message } = (err instanceof Error) ? errorMap[err.message] : { status: 500, message: 'An internal server error occurred.' }

    return new Response(
      JSON.stringify({ error: message }),
      { 
        status, 
        headers: { ...corsHeaders, 'Content-Type': 'application/json' } 
      }
    )
  }
})