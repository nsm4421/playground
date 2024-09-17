# 테이블

## 회원정보

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

    create policy "permit select for all" on accounts for select using (true);

    create policy "can create own account" on accounts
    for update with check (auth.uid() = id);

    create policy "can modify own account" on accounts
    for update with check (auth.uid() = id);

    create policy "can delete own account" on accounts
    for delete using (auth.uid() = id);

## Feed

    create table public.feeds (
    id uuid not null default gen_random_uuid (),
    created_by uuid not null default auth.uid(),
    media text null,
    hashtags text[] DEFAULT '{}',
    caption text null,
    created_at timestamp with time zone not null default now(),
    updated_at timestamp with time zone null,    
    constraint posts_pkey primary key (id),
    constraint posts_user_id_fkey foreign key (created_by)
    references accounts (id) on update cascade on delete cascade
    ) tablespace pg_default;
    
    alter table public.feeds enable row level security;
    
    create policy "permit select for all authenticated" on public.feeds
    for select to authenticated using (true);
    
    create policy "permit insert own data" on public.feeds
    for insert to authenticated with check (auth.uid() = created_by);
    
    create policy "permit update own data" on public.feeds
    for update to authenticated with check (auth.uid() = created_by);
    
    create policy "permit delete own data" on public.feeds
    for update to authenticated with check (auth.uid() = created_by);

## Likes

    create table public.likes (
    id uuid not null default gen_random_uuid (),
    reference_id uuid not null,
    reference_table text not null,
    created_by uuid not null default auth.uid(),
    created_at timestamp with time zone not null default now(),
    constraint likes_pkey primary key (id),
    constraint likes_uid_fkey foreign key (created_by)
    references accounts (id) on update cascade on delete cascade
    ) tablespace pg_default;
    
    alter table public.likes enable row level security;
    
    create policy "permit select for all authenticated" on public.likes
    for select to authenticated using (true);
    
    create policy "permit insert own data" on public.likes
    for insert to authenticated with check (auth.uid() = created_by);
    
    create policy "permit delete own data" on public.likes
    for update to authenticated with check (auth.uid() = created_by);

# 버킷

## 아바타

    insert into storage.buckets (id, name)
    values ('avatars', 'avatars');

    create policy "permit select for all" on storage.objects
    for select using (bucket_id = 'avatars');

    create policy "permit insert for all" on storage.objects
    for insert with check (bucket_id = 'avatars');

## 피드

    insert into storage.buckets (id, name)
    values ('feeds', 'feeds');

    create policy "permit select for all" on storage.objects
    for select using (bucket_id = 'feeds');

    create policy "permit insert for all" on storage.objects
    for insert with check (bucket_id = 'feeds');

# Supabase Functions

## 회원가입

```
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
```


## 피드조회

```
create or replace function fetch_feeds(before_at timestamptz, take int)
returns table(
    feed_id uuid,                     -- 피드 id
    media text,                       -- 피드 사진/동영상 경로
    caption text,                     -- 캡션
    created_at timestamptz,           -- 작성시간
    updated_at timestamptz,           -- 수정시간
    author_id uuid,                   -- 작성자 id
    author_username text,             -- 작성자 유저명
    author_avatar_url text,           -- 작성자 프포필 사진
    like_count int,                   -- 좋아요 개수
    is_like bool                      -- 좋아요 눌렀는지 여부
)
language sql
as $$
    select
      A.id,                         -- feed_id
      A.media,                      -- media
      A.caption,                    -- caption
      A.created_at,                 -- created_at
      A.updated_at,                 -- updated_at      
      B.id,                         -- author_uid
      B.username,                   -- author_username
      B.avatar_url,                 -- author_avatar_url
      C.like_cnt,                   -- like_count
      (D.like_cnt>0)                -- is_like
    from (
        select
            id,
            media,
            caption,
            created_at,
            updated_at,
            created_by
        from
            public.feeds
        where
            created_at < before_at
        ) A 
    -- 글쓴이 정보
    left join public.accounts B on A.created_by = B.id
    -- 해당 게시글에 좋아요 누른 목록
    left join (
      select reference_id, count(1) like_cnt
      from public.likes
      where reference_table = 'feeds'
      group by reference_id
    ) C on A.id = C.reference_id    -- feed id로 left join
    -- 해당 게시글에 내가 좋아요 누른 목록
    left join (
      select reference_id, count(1) like_cnt
      from public.likes
      where reference_table = 'feeds' and created_by = (auth.uid())
      group by reference_id
    ) D on A.id = D.reference_id    -- feed id로 left join
    order by A.created_at desc
    limit(take);
$$;
```