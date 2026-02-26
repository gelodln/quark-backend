alter table "public"."user" add column "email" text not null;

CREATE UNIQUE INDEX user_email_unique ON public."user" USING btree (email);

alter table "public"."user" add constraint "user_email_unique" UNIQUE using index "user_email_unique";


