// deno-lint-ignore-file no-import-prefix
import { createRemoteJWKSet, jwtVerify } from 'https://deno.land/x/jose@v4.14.4/index.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const SUPABASE_URL = Deno.env.get('SUPABASE_URL')!;
const JWKS = createRemoteJWKSet(new URL(`${SUPABASE_URL}/auth/v1/.well-known/jwks.json`));

export async function verifyUser(req: Request) {
  const authHeader = req.headers.get('Authorization');
  if (!authHeader) throw new Error('Missing Authorization header');
  
  const token = authHeader.replace('Bearer ', '');
  const { payload } = await jwtVerify(token, JWKS);
  
  // Extract custom metadata defined in the API contract/auth-login
  const userMetadata = (payload.user_metadata as any) || {};
  
  return {
    id: payload.sub as string,
    role: userMetadata.role as string // "instructor" or "learner"
  };
}

export function authorizeRole(userRole: string, requiredRole: string) {
  if (userRole.toLowerCase() !== requiredRole.toLowerCase()) {
    throw new Error(`Forbidden: Requires ${requiredRole} role`);
  }
}

// Administrative Client for bypassing RLS in Edge Functions.
export const getAdminClient = () => {
  const key = Deno.env.get('SB_SECRET_KEY');
  if (!key) throw new Error('SB_SECRET_KEY environment variable is missing.');
  
  return createClient(SUPABASE_URL, key, {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  });
};