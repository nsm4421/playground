# travel

여행객들을 위한 앱을 만들 계획임

# 기획

> 일기

- 여행을 하고 일기(?)를 포스팅 형태로 작성
- 이 때 시간과 위치, 해시태그 등을 추가
- 공유기능을 통해서 좋아요 댓글 기능 추가함

> Image2Text

- 이미지에서 텍스트를 추출하고, 이를 번역하는 기능
- 번역 기능을 google ml kit로 코드 작성하였는데 모델 다운로드에 시간이 매우 오래걸림
- gemeni api를 사용하는 방식으로 개선할 필요가 있음

# Supabase

`supabse init`
`supabase start`
`supabase status`

# Reference

    > Google ML Kit 

    - Image To Text

        https://pub.dev/packages/google_mlkit_text_recognition

# Script

```
-- create account table
create table public.accounts (
    id uuid not null ,
    email text not null unique,
    username text null,
    avatar_url text null,
    constraint accounts_pkey primary key (id),
    constraint accounts_fkey foreign key (id) 
    references auth.users (id) on update cascade on delete cascade
) tablespace pg_default;

alter table public.accounts enable row level security;

create policy "enable to select for all authenticated" 
on accounts for select using (true);

create policy "enable insert only own data" on accounts
for insert to authenticated with check (auth.uid() = id);

create policy "enable update only own data" on accounts
for update to authenticated with check (auth.uid() = id);

create policy "enable delete only own data" on accounts
for delete to authenticated using (auth.uid() = id);

-- create diary
create table public.diaries (
    id uuid not null default gen_random_uuid (),
    created_by uuid not null default auth.uid(),
    images text[] DEFAULT '{}',
    hashtags text[] DEFAULT '{}',
    captions text[] DEFAULT '{}',
    location text,
    content text,
    is_private bool DEFAULT true,
    created_at timestamp with time zone not null default now(),
    updated_at timestamp with time zone null,    
    constraint diaries_pkey primary key (id),
    constraint diaries_fkey foreign key (created_by)
    references accounts (id) on update cascade on delete cascade
) tablespace pg_default;

alter table public.diaries enable row level security;

create policy "enable to select for all authenticated" 
on diaries for select to authenticated using (true);

create policy "enable insert only own data" on diaries
for insert to authenticated with check (auth.uid() = created_by);

create policy "enable update only own data" on diaries
for update to authenticated with check (auth.uid() = created_by);

create policy "enable delete only own data" on diaries
for delete to authenticated using (auth.uid() = created_by);

-- create open chat
create table public.open_chats (
    id uuid not null default gen_random_uuid(),
    title text,
    hashtags text[] DEFAULT '{}',
    last_message_content text,
    last_message_created_at timestamp with time zone not null default now(),
    created_at timestamp with time zone not null default now(),
    created_by uuid not null default auth.uid(),
    constraint open_chat_pkey primary key (id),
    constraint open_chat_fkey foreign key (created_by)
    references accounts (id) on update cascade on delete cascade
) tablespace pg_default;

alter table public.open_chats enable row level security;

create policy "enable to select for all authenticated" 
on open_chats for select to authenticated using (true);

create policy "enable insert only own data" on open_chats
for insert to authenticated with check (true);

create policy "enable update only own data" on open_chats
for update to authenticated with check (true);

create policy "enable delete only own data" on open_chats
for delete to authenticated using (auth.uid() = created_by);

-- create private chat
create table public.private_chats (
    id uuid not null default gen_random_uuid(),
    uid uuid not null,
    opponent_uid uuid not null,
    last_message_content text,
    last_message_created_at timestamp with time zone not null default now(),
    created_at timestamp with time zone not null default now(),
    constraint private_chat_pkey primary key (id),
    constraint private_chat_fkey1 foreign key (uid)
    references accounts (id) on update cascade on delete cascade,
    constraint private_chat_fkey2 foreign key (opponent_uid)
    references accounts (id) on update cascade on delete cascade
) tablespace pg_default;

alter table public.private_chats enable row level security;

create policy "enable to select for all authenticated" 
on private_chats for select to authenticated using 
((auth.uid()=uid) or (auth.uid()=opponent_uid));

create policy "enable insert only own data" on private_chats
for insert to authenticated with check
((auth.uid()=uid) or (auth.uid()=opponent_uid));

create policy "enable update only own data" on private_chats
for update to authenticated with check
((auth.uid()=uid) or (auth.uid()=opponent_uid));

create policy "enable delete only own data" on private_chats
for delete to authenticated using
((auth.uid()=uid) or (auth.uid()=opponent_uid));

-- create open chat message
create table public.open_chat_messages (
    id uuid not null default gen_random_uuid(),
    chat_id uuid not null,
    content text,
    media text,
    last_message_created_at timestamp with time zone not null default now(),
    created_at timestamp with time zone not null default now(),
    created_by uuid not null default auth.uid(),
    constraint open_chat_message_pkey primary key (id),
    constraint open_chat_message_fkey foreign key (created_by)
    references accounts (id) on update cascade on delete cascade
) tablespace pg_default;

alter table public.open_chat_messages enable row level security;

create policy "enable to select for all authenticated" 
on open_chat_messages for select to authenticated using (true);

create policy "enable insert only own data" on open_chat_messages
for insert to authenticated with check (true);

create policy "enable update only own data" on open_chat_messages
for update to authenticated with check (auth.uid()=created_by);

-- create private chat message
create table public.private_chat_messages (
    id uuid not null default gen_random_uuid(),
    chat_id uuid not null,
    sender uuid not null,
    receiver uuid not null,
    content text,
    media text,
    created_at timestamp with time zone not null default now(),
    removed_at timestamp with time zone,
    created_by uuid not null default auth.uid(),
    constraint private_chat_messages_pkey primary key (id),
    constraint private_chat_messages_fkey1 foreign key (sender)
    references accounts (id) on update cascade on delete cascade,
    constraint private_chat_messages_fkey2 foreign key (receiver)
    references accounts (id) on update cascade on delete cascade
) tablespace pg_default;

alter table public.private_chat_messages enable row level security;

create policy "enable to select for all authenticated" 
on private_chat_messages for select to authenticated using 
((auth.uid()=sender) or (auth.uid()=receiver));

create policy "enable insert only own data" on private_chat_messages
for insert to authenticated with check
((auth.uid()=sender) or (auth.uid()=receiver));

create policy "enable update only own data" on private_chat_messages
for update to authenticated with check
((auth.uid()=sender) or (auth.uid()=receiver) and (auth.uid() = created_by));

create policy "enable delete only own data" on private_chat_messages
for delete to authenticated using
((auth.uid()=sender) or (auth.uid()=receiver) and (auth.uid() = created_by));

------------------------------------------------------
-- avatar bucket
insert into storage.buckets (id, name)
values ('avatar', 'avatar');

create policy "permit select avatar for all" on storage.objects
for select using (bucket_id = 'avatar');

create policy "permit insert avatar for all" on storage.objects
for insert with check (bucket_id = 'avatar');

-- diary bucket
insert into storage.buckets (id, name)
values ('diary', 'diary');

create policy "permit select diary for all" on storage.objects
for select using (bucket_id = 'diary');

create policy "permit insert for all" on storage.objects
for insert with check (bucket_id = 'diary');

------------------------------------------------------

-- on sign up
create or replace function public.on_sign_up()
returns trigger
language plpgsql
security definer set search_path = public
as $$
    begin
    insert into public.accounts (
        id,
        email, 
        username, 
        avatar_url
    )
    values (
        new.id, 
        new.email,
        new.raw_user_meta_data->>'username', 
        new.raw_user_meta_data->>'avatar_url'
    );
    return new;
    end;
$$;

create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.on_sign_up();

------------------------------------------------------

-- on edit profile
create or replace function public.on_edit_profile()
returns trigger
language plpgsql
security definer set search_path = public
as $$
    begin
    update public.accounts 
    set username = new.raw_user_meta_data->>'username', 
        avatar_url = new.raw_user_meta_data->>'avatar_url'
    where id = new.id;
    return new;
    end;
$$;

create trigger on_auth_edited
after update on auth.users
for each row execute procedure public.on_edit_profile();

------------------------------------------------------

-- on fetch diary
create or replace function fetch_diaries
(before_at timestamptz, take int)
returns table(
    id uuid, 
    images text[],
    hashtags text[],
    captions text[],
    location text,
    content text,
    is_private bool,
    created_at timestamptz,
    updated_at timestamptz,
    created_by uuid,
    username text,
    avatar_url text
)
language sql
as $$
    select
      A.id,
      A.images,
      A.hashtags,
      A.captions,
      A.location,
      A.content,
      A.is_private,
      A.created_at,
      A.updated_at,
      A.created_by author_uid,
      B.username author_username,
      B.avatar_url author_avatar_url
    from (
        select
          id,
          images,
          hashtags,
          captions,
          location,
          content,
          is_private,
          created_by,
          created_at,
          updated_at
        from
            public.diaries
        where
            created_at < before_at
            and ((is_private = false) or (created_by = auth.uid()))
        order by created_at desc
        limit(take)
        ) A
    left join public.accounts B on A.created_by = B.id
;
$$
```