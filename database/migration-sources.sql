begin;

alter table public.contact_messages
  add column if not exists source text not null default '' check (char_length(source) <= 60),
  add column if not exists utm_source text not null default '' check (char_length(utm_source) <= 200),
  add column if not exists utm_medium text not null default '' check (char_length(utm_medium) <= 200),
  add column if not exists utm_campaign text not null default '' check (char_length(utm_campaign) <= 200),
  add column if not exists referrer text not null default '' check (char_length(referrer) <= 200);

alter table public.job_applications
  add column if not exists source text not null default '' check (char_length(source) <= 60),
  add column if not exists utm_source text not null default '' check (char_length(utm_source) <= 200),
  add column if not exists utm_medium text not null default '' check (char_length(utm_medium) <= 200),
  add column if not exists utm_campaign text not null default '' check (char_length(utm_campaign) <= 200),
  add column if not exists referrer text not null default '' check (char_length(referrer) <= 200);

grant insert (source, utm_source, utm_medium, utm_campaign, referrer) on table public.contact_messages to anon, authenticated;
grant insert (source, utm_source, utm_medium, utm_campaign, referrer) on table public.job_applications to anon, authenticated;

commit;
