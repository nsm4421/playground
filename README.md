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
    refernce_id uuid not null,
    refernce_table text not null,
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