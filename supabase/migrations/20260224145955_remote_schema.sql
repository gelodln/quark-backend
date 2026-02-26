
  create policy "Allow service role to manage all users"
  on "public"."user"
  as permissive
  for all
  to service_role
using (true)
with check (true);



