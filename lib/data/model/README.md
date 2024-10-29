# Create Tables

## Accounts
```
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
```

## Feeds
```
create table public.feeds (
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
    constraint feeds_pkey primary key (id),
    constraint feeds_fkey foreign key (created_by)
    references accounts (id) on update cascade on delete cascade
) tablespace pg_default;

alter table public.feeds enable row level security;

create policy "enable to select for all authenticated" 
on feeds for select to authenticated using (true);

create policy "enable insert only own data" on feeds
for insert to authenticated with check (auth.uid() = created_by);

create policy "enable update only own data" on feeds
for update to authenticated with check (auth.uid() = created_by);

create policy "enable delete only own data" on feeds
for delete to authenticated using (auth.uid() = created_by);
```

## Chat

- Open Chat
```
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
```

- Private Chat
```
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
for insert to authenticated with check ((auth.uid()=uid) or (auth.uid()=opponent_uid));

create policy "enable update only own data" on private_chats
for update to authenticated 
USING ((auth.uid()=uid) or (auth.uid()=opponent_uid))
with check
((auth.uid()=uid) or (auth.uid()=opponent_uid));

create policy "enable delete only own data" on private_chats
for delete to authenticated using
((auth.uid()=uid) or (auth.uid()=opponent_uid));
```

- Open Chat Message
```
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
for update to authenticated 
USING (auth.uid()=created_by)
with check (auth.uid()=created_by);
```

- Private Chat Message
```
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
for update to authenticated 
USING ((auth.uid()=sender) or (auth.uid()=receiver) and (auth.uid() = created_by)) 
with check ((auth.uid()=sender) or (auth.uid()=receiver) and (auth.uid() = created_by));

create policy "enable delete only own data" on private_chat_messages
for delete to authenticated using
((auth.uid()=sender) or (auth.uid()=receiver) and (auth.uid() = created_by));
```

## Meeting

- meeting
```
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
for update to authenticated 
using(auth.uid()=created_by)
with check (auth.uid()=created_by);

create policy "enable delete only own data" on meetings
for delete to authenticated using (auth.uid()=created_by);
```

- registration
```
create table public.registrations (
    id uuid not null default gen_random_uuid(),
    meeting_id uuid not null,
    manager_id uuid not null,
    proposer_id uuid not null default auth.uid(),
    is_permitted bool default false,
    created_by uuid not null default auth.uid(),
    INTRODUCE text,
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

alter table public.registrations enable row level security;

create policy "enable to select for all authenticated" 
on registrations for select to authenticated using (true);

create policy "enable insert only own data" on registrations
for insert to authenticated with check (auth.uid()=created_by);

create policy "enable update only own data" on registrations
for update to authenticated 
USING (auth.uid() = manager_id)
with check (auth.uid()=manager_id);

create policy "enable delete only own data" on registrations
for delete to authenticated using ((auth.uid()=proposer_id) or (auth.uid()=manager_id));
```

## Comment
```
create table public.comments (
    id uuid not null default gen_random_uuid(),
    reference_table text not null,
    reference_id uuid not null,
    content text,
    created_by uuid not null default auth.uid(),
    created_at timestamp with time zone not null default now(),
    updated_at timestamp with time zone not null,
    constraint comments_pkey primary key (id),
    constraint comments_fkey foreign key (created_by)
    references accounts (id) on update cascade on delete cascade
) tablespace pg_default;

alter table public.comments enable row level security;

create policy "enable to select for all authenticated" 
on comments for select to authenticated using (true);

create policy "enable insert only own data" on comments
for insert to authenticated with check (auth.uid()=created_by);

create policy "enable update only own data" on comments
for update to authenticated 
using (auth.uid()=created_by)
with check (auth.uid()=created_by);

create policy "enable delete only own data" on comments
for delete to authenticated using (auth.uid()=created_by);
```

## Comment
```
create table public.likes (
    id uuid not null default gen_random_uuid(),
    reference_table text not null,
    reference_id uuid not null,
    created_by uuid not null default auth.uid(),
    created_at timestamp with time zone not null default now(),
    constraint likes_pkey primary key (id),
    constraint likes_fkey foreign key (created_by)
    references accounts (id) on update cascade on delete cascade,
    unique(reference_id, reference_table, created_by)
) tablespace pg_default;

alter table public.likes enable row level security;

create policy "enable to select for all authenticated" 
on likes for select to authenticated using (true);

create policy "enable insert only own data" on likes
for insert to authenticated with check (auth.uid()=created_by);

create policy "enable delete only own data" on likes
for delete to authenticated using (auth.uid()=created_by);
```

# Create Buckets

## Avatar

```
insert into storage.buckets (id, name)
values ('avatar', 'avatar');

create policy "permit select avatar for all" on storage.objects
for select using (bucket_id = 'avatar');

create policy "permit insert avatar for all" on storage.objects
for insert with check (bucket_id = 'avatar');
```

## Feeds
```
insert into storage.buckets (id, name)
values ('feed', 'feed');

create policy "permit select feed for all" on storage.objects
for select using (bucket_id = 'feed');

create policy "permit insert for all" on storage.objects
for insert with check (bucket_id = 'feed');
```

## Meeting
```
insert into storage.buckets (id, name)
values ('meeting', 'meeting');

create policy "permit select meeting for all" on storage.objects
for select using (bucket_id = 'meeting');

create policy "permit insert meeting for all" on storage.objects
for insert with check (bucket_id = 'meeting');
```
