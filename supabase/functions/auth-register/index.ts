import { corsHeaders } from '../_shared/util.ts'
import { getAdminClient } from '../_shared/auth.ts';

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  const supabase = getAdminClient()
  let createdAuthUserId: string | null = null

  try {
    const { email, password, roleName } = await req.json()

    if (!email || !password || !roleName) {
      throw new Error('MISSING_FIELDS')
    }

    // Step 1: Create user in Supabase Auth
    // We bypass email verification (email_confirm: true) for this admin flow.
    const { data: authData, error: authError } = await supabase.auth.admin.createUser({
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

    // Step 2: Role Lookup
    // Case-sensitive lookup: 'Instructor' or 'Learner'
    const { data: roleData, error: roleError } = await supabase
      .from('role')
      .select('role_id')
      .eq('role_name', roleName)
      .single()

    if (roleError || !roleData) {
      throw new Error('INVALID_ROLE')
    }

    // Step 3: Relational Profile Creation
    const { error: profileError } = await supabase
      .from('user')
      .insert({
        user_id: authData.user.id, // UUID from Auth
        role_id: roleData.role_id, // int from role table
        email: email,
      })

    if (profileError) throw profileError

    return new Response(
      JSON.stringify({ user_id: authData.user.id }),
      { 
        status: 201, 
        headers: { ...corsHeaders, 'Content-Type': 'application/json' } 
      }
    )

  } catch (err) {
    // Atomicity Protection: Rollback Auth User if relational insert fails
    if (createdAuthUserId) {
      await supabase.auth.admin.deleteUser(createdAuthUserId)
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