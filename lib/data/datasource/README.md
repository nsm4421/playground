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

-----------------------------------------------------

create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.on_sign_up();

-----------------------------------------------------

CREATE OR REPLACE FUNCTION fetch_feeds(_before_at timestamptz, _take int)
RETURNS TABLE(
    ID UUID,
    CONTENT TEXT,
    HASHTAGS TEXT[],
    IMAGES TEXT[],
    CAPTIONS TEXT[],
    CREATED_AT TIMESTAMPTZ,
    UPDATED_AT TIMESTAMPTZ,
    AUTHOR_UID UUID,
    AUTHOR_USERNAME TEXT,
    AUTHOR_AVATAR_URL TEXT
)
language sql
as $$
    select
        T1.ID ID, 
        T1.CONTENT CONTENT, 
        T1.HASHTAGS HASHTAGS, 
        T1.IMAGES IMAGES, 
        T1.CAPTIONS CAPTIONS, 
        T1.CREATED_AT CREATED_AT, 
        T1.UPDATED_AT UPDATED_AT, 
        T1.CREATED_BY AUTHOR_UID, 
        T2.USERNAME AUTHOR_USERNAME, 
        T2.AVATAR_URL AUTHOR_AVATAR_URL
    FROM (
        SELECT
            ID,
            CONTENT,
            HASHTAGS,
            IMAGES,
            CAPTIONS,
            CREATED_AT,
            UPDATED_AT,
            CREATED_BY
        FROM
            FEEDS
        WHERE
            CREATED_AT < _before_at
            AND DELETED_AT IS NULL
        ORDER BY CREATED_AT DESC
        LIMIT(_take)
        ) T1
    LEFT JOIN PUBLIC.ACCOUNTS T2
    ON T1.CREATED_BY = T2.ID
;
$$

-----------------------------------------------------

CREATE OR REPLACE FUNCTION fetch_reels(_before_at timestamptz, _take int)
RETURNS TABLE(
    ID UUID,
    CAPTION TEXT,
    VIDEO TEXT,
    CREATED_AT TIMESTAMPTZ,
    UPDATED_AT TIMESTAMPTZ,
    AUTHOR_UID UUID,
    AUTHOR_USERNAME TEXT,
    AUTHOR_AVATAR_URL TEXT
)
language sql
as $$
    select
        T1.ID ID, 
        T1.CAPTION CAPTION, 
        T1.VIDEO VIDEO, 
        T1.CREATED_AT CREATED_AT, 
        T1.UPDATED_AT UPDATED_AT, 
        T1.CREATED_BY AUTHOR_UID, 
        T2.USERNAME AUTHOR_USERNAME, 
        T2.AVATAR_URL AUTHOR_AVATAR_URL
    FROM (
        SELECT
            ID,
            CAPTION,
            VIDEO,
            CREATED_AT,
            UPDATED_AT,
            CREATED_BY
        FROM
            REELS
        WHERE
            CREATED_AT < _before_at
            AND DELETED_AT IS NULL
        ORDER BY CREATED_AT DESC
        LIMIT(_take)
        ) T1
    LEFT JOIN PUBLIC.ACCOUNTS T2
    ON T1.CREATED_BY = T2.ID
;
$$
```