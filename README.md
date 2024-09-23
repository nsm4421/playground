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
    for delete to authenticated USING (auth.uid() = created_by);

## Comment

    create table public.comments (
    id uuid not null default gen_random_uuid (),
    reference_id uuid not null,
    reference_table text not null,
    parent_id uuid default null,
    content text not null,
    created_by uuid not null default auth.uid(),
    created_at timestamp with time zone not null default now(),
    constraint comments_pkey primary key (id),
    constraint comments_uid_fkey foreign key (created_by)
    references accounts (id) on update cascade on delete cascade
    ) tablespace pg_default;
    
    alter table public.comments enable row level security;
    
    create policy "permit select for all authenticated" on public.comments
    for select to authenticated using (true);
    
    create policy "permit insert own data" on public.comments
    for insert to authenticated with check (auth.uid() = created_by);
    
    create policy "permit update own data" on public.comments
    for update to authenticated with check (auth.uid() = created_by);

    create policy "permit delete own data" on public.comments
    for delete to authenticated USING (auth.uid() = created_by);

## Likes

    create table public.likes (
    id uuid not null default gen_random_uuid (),
    reference_id uuid not null,
    reference_table text not null,
    created_by uuid not null default auth.uid(),
    created_at timestamp with time zone not null default now(),
    constraint likes_pkey primary key (id),
    constraint likes_uid_fkey foreign key (created_by) 
    references accounts (id) on update cascade on delete cascade,
    constraint unique_ref_id_table_created_by UNIQUE (reference_id, reference_table, created_by)
    ) tablespace pg_default;
    
    alter table public.likes enable row level security;
    
    create policy "permit select for all authenticated" on public.likes
    for select to authenticated using (true);
    
    create policy "permit insert own data" on public.likes
    for insert to authenticated with check (auth.uid() = created_by);

    create policy "permit delete own data" on public.likes
    for delete to authenticated USING (auth.uid() = created_by);

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
    id uuid,                          -- 피드 id
    media text,                       -- 피드 사진/동영상 경로
    caption text,                     -- 캡션
    created_at timestamptz,           -- 작성시간
    updated_at timestamptz,           -- 수정시간
    author_id uuid,                   -- 작성자 id
    author_username text,             -- 작성자 유저명
    author_avatar_url text,           -- 작성자 프포필 사진
    like_count int,                   -- 좋아요 개수
    is_like bool,                     -- 좋아요 눌렀는지 여부
    comment_count int,                -- 부모 댓글 개수
    latest_comment_id uuid,           -- 최신 댓글 id
    latest_comment_content text,      -- 최신 댓글 본문
    lastet_comment_created_at timestamptz   
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
      (D.like_cnt>0),               -- is_like
      E.parent_comment_count,       -- comment_count
      F.id,                         -- latest_comment_id
      F.content,                    -- latest_comment
      F.created_at                  -- laset_comment_created_at
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
        limit(take)
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
    -- 댓글 개수
    left join (
      select reference_id, count(1) parent_comment_count
      from public.comments
      where reference_table = 'feeds' 
      group by reference_id
    ) E on A.id = E.reference_id    -- feed id로 left join 
    -- 가장 최신 댓글 정보
    left join (
      select id, reference_id, content, created_at
      from public.comments
      where reference_table = 'feeds' 
      order by created_at desc limit(1)      -- 가장 최신 댓글 1개만
    ) F on A.id = F.reference_id    -- feed id로 left join 
    order by A.created_at desc
;
$$;
```


## 댓글조회

```
create or replace function fetch_parent_comments
(ref_id uuid, ref_tab text, before_at timestamptz, take int)
returns table(
    id uuid,                          -- 부모댓글 id
    content text,                     -- 댓글
    created_at timestamptz,           -- 작성시간
    author_id uuid,                   -- 작성자 id
    author_username text,             -- 작성자 유저명
    author_avatar_url text,           -- 작성자 프포필 사진
    child_comment_count int,          -- 자식댓글 개수
    reference_id uuid,
    reference_table text
)
language sql
as $$
    select
      AA.id id,
      AA.content content,
      AA.created_at,
      BB.id author_id,
      BB.username author_username,
      BB.avatar_url author_avatar_url,
      CC.child_comment_count child_comment_count,
      AA.reference_id reference_id,
      AA.reference_table reference_table
    from (
        select
            id,
            content,
            created_by,
            created_at,
            reference_id,
            reference_table
        from
            public.comments
        where
            created_at < before_at 
            and parent_id is null 
            and reference_id = ref_id
            and reference_table = ref_tab
        limit take
        ) AA   -- 부모댓글
    left join (
        select
          id,
          username,
          avatar_url
        from
          public.accounts
    ) BB on AA.created_by = BB.id  -- 작성자 정보
    left join (
      select count(1) child_comment_count,
        parent_id, 
        reference_id, 
        reference_table
      from public.comments
      where parent_id is not null
        and reference_id = ref_id
        and reference_table = ref_tab
      group by parent_id, reference_id, reference_table
    ) CC on AA.id = CC.parent_id  
    order by AA.created_at desc
$$;
```