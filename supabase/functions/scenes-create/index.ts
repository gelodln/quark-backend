// deno-lint-ignore-file
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { AuthMiddleware } from "../_shared/jwt/default.ts";
import * as jose from "jsr:@panva/jose@6";

Deno.serve((req) =>
  AuthMiddleware(req, async (request) => {
    try {
      // Method Check
      if (request.method !== "POST") {
        return Response.json({ error: "Method Not Allowed" }, { status: 405 });
      }

      // Get User ID from the already-verified JWT
      const authHeader = request.headers.get("Authorization")!;
      const token = authHeader.replace("Bearer ", "");
      const payload = jose.decodeJwt(token);
      const userId = payload.sub; // 'sub' is the User ID in Supabase JWTs

      // Parse Request Body
      const body = await request.json();
      const { topicId, sceneType, title, description } = body;

      if (!topicId || !sceneType) {
        return Response.json({ error: "Missing required fields" }, { status: 400 });
      }

      // Create ADMIN client (using internal kong:8000 URL)
      const adminClient = createClient(
        Deno.env.get("SUPABASE_URL")!,
        Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
      );

      // Adds the created scene to the database
      const { data, error } = await adminClient
        .from("scene")
        .insert({
          owner_id: userId,
          topic_id: topicId,
          scene_type: sceneType,
          title,
          description,
        })
        .select()
        .single();

      if (error) {
        return Response.json({ error: error.message }, { status: 400 });
      }

      // Success
      return Response.json(data, { status: 200 });

    } catch (err) {
      const message = err instanceof Error ? err.message : "Internal Server Error";
      return Response.json({ error: message }, { status: 500 });
    }
  })
);