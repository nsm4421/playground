# travel

여행객들을 위한 앱을 만들 계획임

# 기획

> 피드

- 여행을 하고 일기(?)를 포스팅 형태로 작성
- 이 때 시간과 위치, 해시태그 등을 추가
- 공유기능을 통해서 좋아요 댓글 기능 추가함

> 여행 메이트 찾기

- 같이 여행할 사람을 찾는 공지글 작성 및 조회 기능 만들기
- 댓글 기능 추가하기

> 채팅기능

# Supabase

`supabse init`
`supabase start`
`supabase status`

# Reference

    > Google ML Kit 

    - Image To Text

        https://pub.dev/packages/google_mlkit_text_recognition

# Script


## Create Tables
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

-- create meeting
create table public.meetings (
    id uuid not null default gen_random_uuid(),
    country text not null,
    city text,
    start_date timestamp with time zone not null,
    end_date timestamp with time zone not null,
    head_count int default 2,
    sex text default 'all',
    theme text default 'all',
    min_cost int default 0,
    max_cost int default 10,
    title text,
    content text,
    hashtags text[] DEFAULT '{}',
    thumbnail text,
    created_at timestamp with time zone not null default now(),
    updated_at timestamp with time zone not null,
    created_by uuid not null default auth.uid(),
    constraint meetings_pkey primary key (id),
    constraint meetings_fkey foreign key (created_by)
    references accounts (id) on update cascade on delete cascade
) tablespace pg_default;

alter table public.meetings enable row level security;

create policy "enable to select for all authenticated" 
on meetings for select to authenticated using (true);

create policy "enable insert only own data" on meetings
for insert to authenticated with check (true);

create policy "enable update only own data" on meetings
for update to authenticated with check (auth.uid()=created_by);

create policy "enable delete only own data" on meetings
for delete to authenticated using (auth.uid()=created_by);

-- create registration table
create table public.registration (
    id uuid not null default gen_random_uuid(),
    meeting_id uuid not null,
    manager_id uuid not null,
    proposer_id uuid not null default auth.uid(),
    ids_permitted bool default false,                   -- 등록 신청 허용 여부
    created_by uuid not null default auth.uid(),        -- 등록 신청한 유저 id
    created_at timestamp with time zone not null default now(),
    updated_at timestamp with time zone not null,
    constraint registration_pkey primary key (id),
    UNIQUE (meeting_id, created_by),   -- meeting id와 등록신청한 유저 id로 unique 조건 걸기
    constraint registration_fkey1 foreign key (meeting_id)
    references meetings (id) on update cascade on delete cascade,
    constraint registration_fkey2 foreign key (created_by)
    references accounts (id) on update cascade on delete cascade,
    constraint registration_fkey3 foreign key (manager_id)
    references accounts (id) on update cascade on delete cascade
) tablespace pg_default;

alter table public.registration enable row level security;

create policy "enable to select for all authenticated" 
on registration for select to authenticated using (true);

create policy "enable insert only own data" on registration
for insert to authenticated with check (auth.uid()=created_by);

create policy "enable update only own data" on registration
for update to authenticated with check (auth.uid()=manager_id);

create policy "enable delete only own data" on registration
for delete to authenticated using ((auth.uid()=proposer_id) or (auth.uid()=manager_id));
```

## Create Buckets

```
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

-- meeting bucket
insert into storage.buckets (id, name)
values ('meeting', 'meeting');

create policy "permit select meeting for all" on storage.objects
for select using (bucket_id = 'meeting');

create policy "permit insert meeting for all" on storage.objects
for insert with check (bucket_id = 'meeting');
```

## Rpc Function
```
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

-- on fetch meeting
create or replace function fetch_meetings
(before_at timestamptz, take int)
returns table(
    country text,
    city text,
    start_date timestamptz,
    end_date timestamptz,
    head_count int,
    sex text,
    theme text ,
    min_cost int,
    max_cost int,
    title text,
    content text,
    hashtags text[],
    thumbnail text,
    id uuid, 
    created_at timestamptz,
    updated_at timestamptz,
    author_uid uuid,
    author_username text,
    author_avatar_url text
)
language sql
as $$
    select
          A.country,
          A.city,
          A.start_date,
          A.end_date,
          A.head_count,
          A.sex,
          A.theme,
          A.min_cost,
          A.max_cost,
          A.title,
          A.content,
          A.hashtags,
          A.thumbnail,
          A.id,
          A.created_at,
          A.updated_at,
          A.created_by author_uid,
          B.username author_username,
          B.avatar_url author_avatar_url
    from (
        select
          country,
          city,
          start_date,
          end_date,
          head_count,
          sex,
          theme,
          min_cost,
          max_cost,
          title,
          content,
          hashtags,
          thumbnail,
          id,
          created_at,
          updated_at,
          created_by
        from
            public.meetings
        where
            created_at < before_at
        order by created_at desc
        limit(take)
        ) A
    left join public.accounts B on A.created_by = B.id
;
$$

CREATE OR REPLACE FUNCTION create_registration(meeting_id uuid)
RETURNS UUID AS $$
DECLARE
    max_head_count int;         -- 최대 인원
    currernt_head_count int;    -- 현재 승인된 인원
    manager_uid uuid;
    new_registration_id uuid;
BEGIN
    -- 변수에 값 할당하기
    SELECT head_count, created_by INTO max_head_count, manager_uid
    FROM meetings
    WHERE id = meeting_id;
    
    SELECT count(1) INTO currernt_head_count
    FROM meetings
    WHERE id = meeting_id
    and is_permited = true
    ;
 
    -- 에러처리
    if not found then
        RAISE EXCEPTION 'meeting with id % does not exist', meeting_id;
    ELSIF max_head_count <= currernt_head_count then
        RAISE EXCEPTION 'head count can not exceed %', max_head_count;
    end if;

    INSERT INTO registrations (
        meeting_id,
        manager_id,
        proposer_id,
        is_permitted,
        created_by,
        created_at,
        updated_at
    ) VALUES (
        meeting_id,
        manager_uid,
        auth.uid(),
        false,
        auth.uid(),
        NOW() AT TIME ZONE 'UTC',
        NOW() AT TIME ZONE 'UTC'
    )
    RETURNING id INTO new_registration_id
    ;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fetch_registrations(meeting_id_to_fetch uuid)
RETURNS table(
    ID uuid,
    MEETING_ID UUID,
    MANAGER_ID UUID,
    MANAGER_USERNAME TEXT,
    MANAGER_AVATAR_URL TEXT,
    CREATED_BY UUID,
    PROPOSER_ID UUID,
    PROPOSER_USERNAME TEXT,
    PROPOSER_AVATAR_URL TEXT,
    IS_PERMITTED BOOL,
    created_at timestamptz
)
AS $$
BEGIN
    SELECT 
        A.ID,
        A.MEETING_ID,
        A.MANAGER_ID,
        C.MANAGER_USERNAME,
        C.MANAGER_AVATAR_URL,
        A.CREATED_BY,
        A.PROPOSER_ID,
        B.USERNAME PROPOSER_USERNAME,
        B.AVATAR_URL PROPOSER_AVATAR_URL,
        A.IS_PERMITTED,
        A.CREATED_AT 
    FROM (
        SELECT 
            ID,
            MEETING_ID,
            CREATED_BY,
            MANAGER_ID,
            PROPOSER_ID,
            IS_PERMITTED,
            CREATED_AT       
        FROM REGISTRATIONS
        WHERE MEETING_ID = meeting_id_to_fetch
    ) A LEFT JOIN (
        SELECT 
            ID,
            USERNAME,
            AVATAR_URL
        FROM ACCOUNTS
    ) B ON A.PROPOSER_ID = B.ID  
    LEFT JOIN (
        SELECT
            ID,
            USERNAME,
            AVATAR_URL
        FROM ACCOUNTS
    ) C ON A.MANAGER_ID = C.ID
    ;
END;
$$ LANGUAGE plpgsql;


-- on meeting created
CREATE OR REPLACE FUNCTION PUBLIC.ON_MEETING_CREATED()
returns trigger
language plpgsql
security definer set search_path = public
as $$
    begin
    PERFORM create_registration(NEW.MEETING_ID);
    RETURN NEW;
    end;
$$;

create trigger on_auth_edited
after update on public.meetings
for each row execute procedure PUBLIC.ON_MEETING_CREATED();

```