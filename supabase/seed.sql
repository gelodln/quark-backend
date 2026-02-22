SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict EMGrqDXiJwLJaZ5XochCfvONn3vOjZcn4bvAN9p3fHZY7ahs3fJFZ7deWydp6xL

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES
	('00000000-0000-0000-0000-000000000000', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', 'authenticated', 'authenticated', 'gelo@up.edu.ph', '$2a$10$W3huPBfEEEc1x0iFXOyDmerkIBPfa6aLPkeHMx.E9XaXn/NQjJS2S', '2026-02-19 18:44:30.181571+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-02-22 14:05:01.475097+00', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2026-02-19 18:44:30.125691+00', '2026-02-22 14:05:01.514981+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('b34fd64e-295f-41f0-a338-0f0c073f1cd4', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', '{"sub": "b34fd64e-295f-41f0-a338-0f0c073f1cd4", "email": "gelo@up.edu.ph", "email_verified": false, "phone_verified": false}', 'email', '2026-02-19 18:44:30.164505+00', '2026-02-19 18:44:30.164562+00', '2026-02-19 18:44:30.164562+00', 'c63b04d6-a13e-4d1d-80b1-3050d1f4e8d6');


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag", "oauth_client_id", "refresh_token_hmac_key", "refresh_token_counter", "scopes") VALUES
	('26554f64-17e6-4dc3-84a7-50b82ad17317', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', '2026-02-19 19:04:48.006282+00', '2026-02-19 19:04:48.006282+00', NULL, 'aal1', NULL, NULL, 'node', '112.198.254.113', NULL, NULL, NULL, NULL, NULL),
	('296950fb-2dad-4d1a-8668-8f3f675ca073', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', '2026-02-21 22:24:16.878805+00', '2026-02-21 22:24:16.878805+00', NULL, 'aal1', NULL, NULL, 'node', '112.198.254.113', NULL, NULL, NULL, NULL, NULL),
	('7c9f58c4-7ac1-4829-bf4c-cdfc7a49e371', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', '2026-02-21 22:37:17.168029+00', '2026-02-21 22:37:17.168029+00', NULL, 'aal1', NULL, NULL, 'node', '112.198.254.113', NULL, NULL, NULL, NULL, NULL),
	('bba3417f-569f-4887-85bd-865f52be1e33', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', '2026-02-21 23:24:55.24361+00', '2026-02-21 23:24:55.24361+00', NULL, 'aal1', NULL, NULL, 'node', '112.198.254.113', NULL, NULL, NULL, NULL, NULL),
	('c5433722-68f7-48f4-a351-20240f4c0d00', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', '2026-02-22 11:32:39.095928+00', '2026-02-22 11:32:39.095928+00', NULL, 'aal1', NULL, NULL, 'node', '112.198.254.113', NULL, NULL, NULL, NULL, NULL),
	('44d4cf8a-6bf4-4a08-b446-ac22a571fe22', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', '2026-02-22 11:35:03.919776+00', '2026-02-22 11:35:03.919776+00', NULL, 'aal1', NULL, NULL, 'node', '112.198.254.113', NULL, NULL, NULL, NULL, NULL),
	('2374cb47-84ea-4f51-8ddd-9d8e1fbe7b45', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', '2026-02-22 11:59:53.059839+00', '2026-02-22 11:59:53.059839+00', NULL, 'aal1', NULL, NULL, 'node', '112.198.254.113', NULL, NULL, NULL, NULL, NULL),
	('3a102553-f335-4250-b83f-dc55792d428c', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', '2026-02-22 12:04:30.086043+00', '2026-02-22 12:04:30.086043+00', NULL, 'aal1', NULL, NULL, 'node', '112.198.254.113', NULL, NULL, NULL, NULL, NULL),
	('f40c5946-7f05-47ef-9d32-92e0b1825e57', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', '2026-02-22 12:05:27.383303+00', '2026-02-22 12:05:27.383303+00', NULL, 'aal1', NULL, NULL, 'node', '112.198.254.113', NULL, NULL, NULL, NULL, NULL),
	('f74b3320-5d12-4218-96dc-73e56da27a7e', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', '2026-02-22 12:05:31.201469+00', '2026-02-22 12:05:31.201469+00', NULL, 'aal1', NULL, NULL, 'node', '112.198.254.113', NULL, NULL, NULL, NULL, NULL),
	('cb8365d2-69a5-401f-a707-707ce52afd3e', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', '2026-02-22 12:14:30.408639+00', '2026-02-22 12:14:30.408639+00', NULL, 'aal1', NULL, NULL, 'node', '112.198.254.113', NULL, NULL, NULL, NULL, NULL),
	('c34f97cc-4a2d-4f56-9df1-493003d59fbd', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', '2026-02-22 12:17:11.866179+00', '2026-02-22 12:17:11.866179+00', NULL, 'aal1', NULL, NULL, 'node', '112.198.254.113', NULL, NULL, NULL, NULL, NULL),
	('eec0c6c1-508a-4b95-a39c-546b85598cf3', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', '2026-02-22 13:42:19.623151+00', '2026-02-22 13:42:19.623151+00', NULL, 'aal1', NULL, NULL, 'node', '112.198.254.113', NULL, NULL, NULL, NULL, NULL),
	('2bca8c14-bdd8-40db-a8b7-38dc76346f71', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', '2026-02-22 13:49:01.793505+00', '2026-02-22 13:49:01.793505+00', NULL, 'aal1', NULL, NULL, 'node', '112.198.254.113', NULL, NULL, NULL, NULL, NULL),
	('9ca6ac02-f8e8-49b3-a6f5-4560faa52c4c', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', '2026-02-22 13:51:02.381408+00', '2026-02-22 13:51:02.381408+00', NULL, 'aal1', NULL, NULL, 'node', '112.198.254.113', NULL, NULL, NULL, NULL, NULL),
	('cbac30b1-5ccb-4fdb-abe9-8594f803ff2e', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', '2026-02-22 13:54:19.833904+00', '2026-02-22 13:54:19.833904+00', NULL, 'aal1', NULL, NULL, 'node', '112.198.254.113', NULL, NULL, NULL, NULL, NULL),
	('0225b774-70fa-41a4-9a08-28f5cc901065', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', '2026-02-22 14:05:01.475912+00', '2026-02-22 14:05:01.475912+00', NULL, 'aal1', NULL, NULL, 'node', '112.198.254.113', NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") VALUES
	('26554f64-17e6-4dc3-84a7-50b82ad17317', '2026-02-19 19:04:48.030344+00', '2026-02-19 19:04:48.030344+00', 'password', '66eea416-dad0-49c7-925b-347dfcd5930e'),
	('296950fb-2dad-4d1a-8668-8f3f675ca073', '2026-02-21 22:24:16.905451+00', '2026-02-21 22:24:16.905451+00', 'password', '6b73689e-4559-40a3-bb7d-95254b2979af'),
	('7c9f58c4-7ac1-4829-bf4c-cdfc7a49e371', '2026-02-21 22:37:17.197163+00', '2026-02-21 22:37:17.197163+00', 'password', 'e074dcb0-fd28-4a34-8a11-6837b7a31167'),
	('bba3417f-569f-4887-85bd-865f52be1e33', '2026-02-21 23:24:55.320801+00', '2026-02-21 23:24:55.320801+00', 'password', 'de9919fb-3680-4ba5-8fe7-cc7b207ee3c4'),
	('c5433722-68f7-48f4-a351-20240f4c0d00', '2026-02-22 11:32:39.110699+00', '2026-02-22 11:32:39.110699+00', 'password', '489feb62-b147-422d-91db-66d6ad4b2e0d'),
	('44d4cf8a-6bf4-4a08-b446-ac22a571fe22', '2026-02-22 11:35:03.935722+00', '2026-02-22 11:35:03.935722+00', 'password', 'b94be4d8-b48c-48e4-8de5-a7b66b94d891'),
	('2374cb47-84ea-4f51-8ddd-9d8e1fbe7b45', '2026-02-22 11:59:53.122782+00', '2026-02-22 11:59:53.122782+00', 'password', '7b9e2f46-dda9-4fe4-b46b-f190d9f1372a'),
	('3a102553-f335-4250-b83f-dc55792d428c', '2026-02-22 12:04:30.106461+00', '2026-02-22 12:04:30.106461+00', 'password', '6b0f38a7-76e3-48df-a71e-a023e001f5b5'),
	('f40c5946-7f05-47ef-9d32-92e0b1825e57', '2026-02-22 12:05:27.386812+00', '2026-02-22 12:05:27.386812+00', 'password', '85e8742a-99cd-4550-b74d-7f1ef6695385'),
	('f74b3320-5d12-4218-96dc-73e56da27a7e', '2026-02-22 12:05:31.206606+00', '2026-02-22 12:05:31.206606+00', 'password', '420b510d-1a66-478f-8dd3-e913a1432054'),
	('cb8365d2-69a5-401f-a707-707ce52afd3e', '2026-02-22 12:14:30.427088+00', '2026-02-22 12:14:30.427088+00', 'password', '6ac97a72-1e1a-452c-a8cb-49a819601718'),
	('c34f97cc-4a2d-4f56-9df1-493003d59fbd', '2026-02-22 12:17:11.871992+00', '2026-02-22 12:17:11.871992+00', 'password', '44fa4058-d890-4d44-bba9-a9dde2bfc586'),
	('eec0c6c1-508a-4b95-a39c-546b85598cf3', '2026-02-22 13:42:19.673272+00', '2026-02-22 13:42:19.673272+00', 'password', 'a9f64f3a-cd0a-4b22-87ff-952f9747f0e1'),
	('2bca8c14-bdd8-40db-a8b7-38dc76346f71', '2026-02-22 13:49:01.809231+00', '2026-02-22 13:49:01.809231+00', 'password', 'ad9cdfd1-4004-4620-bbe9-49ec59c7c0b2'),
	('9ca6ac02-f8e8-49b3-a6f5-4560faa52c4c', '2026-02-22 13:51:02.390134+00', '2026-02-22 13:51:02.390134+00', 'password', '7e6be40f-c4f7-4686-8677-236754a2e906'),
	('cbac30b1-5ccb-4fdb-abe9-8594f803ff2e', '2026-02-22 13:54:19.845673+00', '2026-02-22 13:54:19.845673+00', 'password', 'ef568eac-1b75-41de-bff1-04e5c1b5d22e'),
	('0225b774-70fa-41a4-9a08-28f5cc901065', '2026-02-22 14:05:01.51657+00', '2026-02-22 14:05:01.51657+00', 'password', '8877366d-cdff-4b6b-82d4-781f244e131a');


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") VALUES
	('00000000-0000-0000-0000-000000000000', 1, 'wmlkpc7gv7mp', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', false, '2026-02-19 19:04:48.016793+00', '2026-02-19 19:04:48.016793+00', NULL, '26554f64-17e6-4dc3-84a7-50b82ad17317'),
	('00000000-0000-0000-0000-000000000000', 2, 'bdve7lljuzq4', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', false, '2026-02-21 22:24:16.895757+00', '2026-02-21 22:24:16.895757+00', NULL, '296950fb-2dad-4d1a-8668-8f3f675ca073'),
	('00000000-0000-0000-0000-000000000000', 3, 'kcprd37aiqux', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', false, '2026-02-21 22:37:17.186517+00', '2026-02-21 22:37:17.186517+00', NULL, '7c9f58c4-7ac1-4829-bf4c-cdfc7a49e371'),
	('00000000-0000-0000-0000-000000000000', 4, '3fc4rfyts3pp', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', false, '2026-02-21 23:24:55.287458+00', '2026-02-21 23:24:55.287458+00', NULL, 'bba3417f-569f-4887-85bd-865f52be1e33'),
	('00000000-0000-0000-0000-000000000000', 5, 'c3v5l35xihpy', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', false, '2026-02-22 11:32:39.106517+00', '2026-02-22 11:32:39.106517+00', NULL, 'c5433722-68f7-48f4-a351-20240f4c0d00'),
	('00000000-0000-0000-0000-000000000000', 6, 'hxxghnax2nug', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', false, '2026-02-22 11:35:03.929613+00', '2026-02-22 11:35:03.929613+00', NULL, '44d4cf8a-6bf4-4a08-b446-ac22a571fe22'),
	('00000000-0000-0000-0000-000000000000', 7, 'ddddlpf5vfdn', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', false, '2026-02-22 11:59:53.096563+00', '2026-02-22 11:59:53.096563+00', NULL, '2374cb47-84ea-4f51-8ddd-9d8e1fbe7b45'),
	('00000000-0000-0000-0000-000000000000', 8, 'z2nh7ifhhgmx', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', false, '2026-02-22 12:04:30.098072+00', '2026-02-22 12:04:30.098072+00', NULL, '3a102553-f335-4250-b83f-dc55792d428c'),
	('00000000-0000-0000-0000-000000000000', 9, 'yf77jzewnjaf', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', false, '2026-02-22 12:05:27.385615+00', '2026-02-22 12:05:27.385615+00', NULL, 'f40c5946-7f05-47ef-9d32-92e0b1825e57'),
	('00000000-0000-0000-0000-000000000000', 10, 'c3jywcp4ovts', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', false, '2026-02-22 12:05:31.202738+00', '2026-02-22 12:05:31.202738+00', NULL, 'f74b3320-5d12-4218-96dc-73e56da27a7e'),
	('00000000-0000-0000-0000-000000000000', 11, 'aalwhsjrvb5o', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', false, '2026-02-22 12:14:30.421869+00', '2026-02-22 12:14:30.421869+00', NULL, 'cb8365d2-69a5-401f-a707-707ce52afd3e'),
	('00000000-0000-0000-0000-000000000000', 12, 'tcna5z7cipfw', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', false, '2026-02-22 12:17:11.867945+00', '2026-02-22 12:17:11.867945+00', NULL, 'c34f97cc-4a2d-4f56-9df1-493003d59fbd'),
	('00000000-0000-0000-0000-000000000000', 13, 'va535fcn3fii', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', false, '2026-02-22 13:42:19.651008+00', '2026-02-22 13:42:19.651008+00', NULL, 'eec0c6c1-508a-4b95-a39c-546b85598cf3'),
	('00000000-0000-0000-0000-000000000000', 14, 'rc2khxxeepgj', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', false, '2026-02-22 13:49:01.803751+00', '2026-02-22 13:49:01.803751+00', NULL, '2bca8c14-bdd8-40db-a8b7-38dc76346f71'),
	('00000000-0000-0000-0000-000000000000', 15, '7xvcser3yraf', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', false, '2026-02-22 13:51:02.386074+00', '2026-02-22 13:51:02.386074+00', NULL, '9ca6ac02-f8e8-49b3-a6f5-4560faa52c4c'),
	('00000000-0000-0000-0000-000000000000', 16, 'bk266nnrou3a', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', false, '2026-02-22 13:54:19.84033+00', '2026-02-22 13:54:19.84033+00', NULL, 'cbac30b1-5ccb-4fdb-abe9-8594f803ff2e'),
	('00000000-0000-0000-0000-000000000000', 17, 'n2l3yk3qsxl5', 'b34fd64e-295f-41f0-a338-0f0c073f1cd4', false, '2026-02-22 14:05:01.497108+00', '2026-02-22 14:05:01.497108+00', NULL, '0225b774-70fa-41a4-9a08-28f5cc901065');


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."role" ("role_name", "role_id") VALUES
	('learner', 1),
	('instructor', 2);


--
-- Data for Name: topic; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."topic" ("topic_name", "topic_id") VALUES
	('Gravity', 1),
	('Friction', 2),
	('Energy Transformation', 3),
	('Simple Machines', 4);


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."user" ("user_id", "created_at", "role_id") VALUES
	('b34fd64e-295f-41f0-a338-0f0c073f1cd4', '2026-02-19 18:53:17.339288+00', 2);


--
-- Data for Name: scene; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: attempt; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: attempt_event; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: scene_access; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: scene_criterion; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: scene_snapshot; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 17, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict EMGrqDXiJwLJaZ5XochCfvONn3vOjZcn4bvAN9p3fHZY7ahs3fJFZ7deWydp6xL

RESET ALL;
