drop policy "Enable insert for authenticated users only" on "public"."user";


  create policy "Enable insert for authenticated users only"
  on "public"."user"
  as permissive
  for insert
  to authenticated
with check ((( SELECT auth.uid() AS uid) = user_id));



