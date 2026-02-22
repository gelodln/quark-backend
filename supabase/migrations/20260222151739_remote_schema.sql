


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";





SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."attempt" (
    "attempt_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "scene_id" "uuid",
    "student_id" "uuid",
    "success" boolean,
    "score" numeric,
    "started_at" timestamp with time zone DEFAULT "now"(),
    "finished_at" timestamp with time zone
);


ALTER TABLE "public"."attempt" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."attempt_event" (
    "event_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "attempt_id" "uuid",
    "event_type" "text" NOT NULL,
    "event_timestamp" timestamp with time zone DEFAULT "now"(),
    "object_id" "uuid",
    "parameter_changed" "text",
    "old_value" numeric,
    "new_value" numeric,
    "metadata" "jsonb" DEFAULT '{}'::"jsonb"
);


ALTER TABLE "public"."attempt_event" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."role" (
    "role_name" "text" NOT NULL,
    "role_id" integer NOT NULL,
    CONSTRAINT "role_role_name_check" CHECK (("role_name" = ANY (ARRAY['instructor'::"text", 'learner'::"text"])))
);


ALTER TABLE "public"."role" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."scene" (
    "scene_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "owner_id" "uuid",
    "scene_type" "text" NOT NULL,
    "title" "text",
    "description" "text",
    "scene_data" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "is_published" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "topic_id" integer,
    CONSTRAINT "scene_scene_type_check" CHECK (("scene_type" = ANY (ARRAY['level'::"text", 'freebuild'::"text"])))
);


ALTER TABLE "public"."scene" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."scene_access" (
    "access_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "scene_id" "uuid",
    "access_code" "text" NOT NULL,
    "expires_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."scene_access" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."scene_criterion" (
    "criterion_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "scene_id" "uuid",
    "criterion_type" "text" NOT NULL,
    "target_object_id" "uuid",
    "secondary_object_id" "uuid",
    "attribute_name" "text",
    "comparison_operator" "text",
    "success_threshold" numeric,
    "metadata" "jsonb" DEFAULT '{}'::"jsonb"
);


ALTER TABLE "public"."scene_criterion" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."scene_snapshot" (
    "snapshot_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "scene_id" "uuid",
    "user_id" "uuid",
    "snapshot_name" "text",
    "scene_data" "jsonb" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."scene_snapshot" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."topic" (
    "topic_name" "text" NOT NULL,
    "topic_id" integer NOT NULL
);


ALTER TABLE "public"."topic" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user" (
    "user_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "role_id" integer
);


ALTER TABLE "public"."user" OWNER TO "postgres";


ALTER TABLE ONLY "public"."attempt_event"
    ADD CONSTRAINT "attempt_event_pkey" PRIMARY KEY ("event_id");



ALTER TABLE ONLY "public"."attempt"
    ADD CONSTRAINT "attempt_pkey" PRIMARY KEY ("attempt_id");



ALTER TABLE ONLY "public"."role"
    ADD CONSTRAINT "role_pkey" PRIMARY KEY ("role_id");



ALTER TABLE ONLY "public"."role"
    ADD CONSTRAINT "role_role_name_key" UNIQUE ("role_name");



ALTER TABLE ONLY "public"."scene_access"
    ADD CONSTRAINT "scene_access_access_code_key" UNIQUE ("access_code");



ALTER TABLE ONLY "public"."scene_access"
    ADD CONSTRAINT "scene_access_pkey" PRIMARY KEY ("access_id");



ALTER TABLE ONLY "public"."scene_criterion"
    ADD CONSTRAINT "scene_criterion_pkey" PRIMARY KEY ("criterion_id");



ALTER TABLE ONLY "public"."scene"
    ADD CONSTRAINT "scene_pkey" PRIMARY KEY ("scene_id");



ALTER TABLE ONLY "public"."scene_snapshot"
    ADD CONSTRAINT "scene_snapshot_pkey" PRIMARY KEY ("snapshot_id");



ALTER TABLE ONLY "public"."topic"
    ADD CONSTRAINT "topic_pkey" PRIMARY KEY ("topic_id");



ALTER TABLE ONLY "public"."topic"
    ADD CONSTRAINT "topic_topic_name_key" UNIQUE ("topic_name");



ALTER TABLE ONLY "public"."user"
    ADD CONSTRAINT "user_pkey" PRIMARY KEY ("user_id");



ALTER TABLE ONLY "public"."attempt_event"
    ADD CONSTRAINT "attempt_event_attempt_id_fkey" FOREIGN KEY ("attempt_id") REFERENCES "public"."attempt"("attempt_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."attempt"
    ADD CONSTRAINT "attempt_scene_id_fkey" FOREIGN KEY ("scene_id") REFERENCES "public"."scene"("scene_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."attempt"
    ADD CONSTRAINT "attempt_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."user"("user_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."scene_access"
    ADD CONSTRAINT "scene_access_scene_id_fkey" FOREIGN KEY ("scene_id") REFERENCES "public"."scene"("scene_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."scene_criterion"
    ADD CONSTRAINT "scene_criterion_scene_id_fkey" FOREIGN KEY ("scene_id") REFERENCES "public"."scene"("scene_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."scene"
    ADD CONSTRAINT "scene_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "public"."user"("user_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."scene_snapshot"
    ADD CONSTRAINT "scene_snapshot_scene_id_fkey" FOREIGN KEY ("scene_id") REFERENCES "public"."scene"("scene_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."scene_snapshot"
    ADD CONSTRAINT "scene_snapshot_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."user"("user_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."scene"
    ADD CONSTRAINT "scene_topic_id_fkey" FOREIGN KEY ("topic_id") REFERENCES "public"."topic"("topic_id");



ALTER TABLE ONLY "public"."user"
    ADD CONSTRAINT "user_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "public"."role"("role_id");



ALTER TABLE ONLY "public"."user"
    ADD CONSTRAINT "user_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



CREATE POLICY "Access via attempt ownership" ON "public"."attempt_event" USING ((EXISTS ( SELECT 1
   FROM "public"."attempt"
  WHERE (("attempt"."attempt_id" = "attempt_event"."attempt_id") AND ("attempt"."student_id" = "auth"."uid"())))));



CREATE POLICY "Anyone can read roles" ON "public"."role" FOR SELECT USING (true);



CREATE POLICY "Anyone can read topics" ON "public"."topic" FOR SELECT USING (true);



CREATE POLICY "Instructor views attempts" ON "public"."attempt" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."scene"
  WHERE (("scene"."scene_id" = "attempt"."scene_id") AND ("scene"."owner_id" = "auth"."uid"())))));



CREATE POLICY "Owner full access" ON "public"."scene" USING (("auth"."uid"() = "owner_id"));



CREATE POLICY "Owner manages access" ON "public"."scene_access" USING (("auth"."uid"() = ( SELECT "scene"."owner_id"
   FROM "public"."scene"
  WHERE ("scene"."scene_id" = "scene_access"."scene_id"))));



CREATE POLICY "Owner manages criteria" ON "public"."scene_criterion" USING (("auth"."uid"() = ( SELECT "scene"."owner_id"
   FROM "public"."scene"
  WHERE ("scene"."scene_id" = "scene_criterion"."scene_id"))));



CREATE POLICY "Read published scenes" ON "public"."scene" FOR SELECT USING (("is_published" = true));



CREATE POLICY "Student manages own attempts" ON "public"."attempt" USING (("auth"."uid"() = "student_id"));



CREATE POLICY "User manages own snapshots" ON "public"."scene_snapshot" USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own profile" ON "public"."user" FOR SELECT USING (("auth"."uid"() = "user_id"));



ALTER TABLE "public"."attempt" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."attempt_event" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."role" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."scene" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."scene_access" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."scene_criterion" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."scene_snapshot" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."topic" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."user" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";








































































































































































GRANT ALL ON TABLE "public"."attempt" TO "anon";
GRANT ALL ON TABLE "public"."attempt" TO "authenticated";
GRANT ALL ON TABLE "public"."attempt" TO "service_role";



GRANT ALL ON TABLE "public"."attempt_event" TO "anon";
GRANT ALL ON TABLE "public"."attempt_event" TO "authenticated";
GRANT ALL ON TABLE "public"."attempt_event" TO "service_role";



GRANT ALL ON TABLE "public"."role" TO "anon";
GRANT ALL ON TABLE "public"."role" TO "authenticated";
GRANT ALL ON TABLE "public"."role" TO "service_role";



GRANT ALL ON TABLE "public"."scene" TO "anon";
GRANT ALL ON TABLE "public"."scene" TO "authenticated";
GRANT ALL ON TABLE "public"."scene" TO "service_role";



GRANT ALL ON TABLE "public"."scene_access" TO "anon";
GRANT ALL ON TABLE "public"."scene_access" TO "authenticated";
GRANT ALL ON TABLE "public"."scene_access" TO "service_role";



GRANT ALL ON TABLE "public"."scene_criterion" TO "anon";
GRANT ALL ON TABLE "public"."scene_criterion" TO "authenticated";
GRANT ALL ON TABLE "public"."scene_criterion" TO "service_role";



GRANT ALL ON TABLE "public"."scene_snapshot" TO "anon";
GRANT ALL ON TABLE "public"."scene_snapshot" TO "authenticated";
GRANT ALL ON TABLE "public"."scene_snapshot" TO "service_role";



GRANT ALL ON TABLE "public"."topic" TO "anon";
GRANT ALL ON TABLE "public"."topic" TO "authenticated";
GRANT ALL ON TABLE "public"."topic" TO "service_role";



GRANT ALL ON TABLE "public"."user" TO "anon";
GRANT ALL ON TABLE "public"."user" TO "authenticated";
GRANT ALL ON TABLE "public"."user" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";































drop extension if exists "pg_net";


