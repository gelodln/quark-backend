alter table "public"."scene_criterion" alter column "secondary_object_id" set data type text using "secondary_object_id"::text;

alter table "public"."scene_criterion" alter column "target_object_id" set data type text using "target_object_id"::text;


