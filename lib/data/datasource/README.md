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
    AUTHOR_ID UUID,
    AUTHOR_USERNAME TEXT,
    AUTHOR_AVATAR_URL TEXT,
    IS_LIKE BOOLEAN,
    LIKE_COUNT INT,
    LATEST_COMMENT TEXT
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
        T1.CREATED_BY AUTHOR_ID, 
        T2.USERNAME AUTHOR_USERNAME, 
        T2.AVATAR_URL AUTHOR_AVATAR_URL,
        (T3.REFERENCE_ID IS NOT NULL) IS_LIKE,
        T4.LIKE_COUNT LIKE_COUNT,
        T5.CONTENT
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
    LEFT JOIN (
        SELECT 
            REFERENCE_ID,
            EMOTION
        FROM PUBLIC.EMOTIONS
        WHERE REFERENCE_TABLE = 'FEEDS'
            AND EMOTION = 'LIKES'
            AND CREATED_BY = AUTH.UID()
    ) T3 ON T1.ID = T3.REFERENCE_ID
    LEFT JOIN (
        SELECT
            REFERENCE_ID,
            COUNT(1) LIKE_COUNT
        FROM PUBLIC.EMOTIONS
        WHERE REFERENCE_TABLE = 'FEEDS'
            AND EMOTION = 'LIKES'
        GROUP BY REFERENCE_ID
    ) T4 ON T1.ID = T4.REFERENCE_ID
    LEFT JOIN (
        SELECT
          TT5.REFERENCE_ID,
          TT5.CONTENT
        FROM (
          SELECT
            REFERENCE_ID,
            CONTENT,
            ROW_NUMBER() OVER (
                PARTITION BY REFERENCE_ID 
                ORDER BY CREATED_AT DESC
            ) AS RANK
          FROM PUBLIC.COMMENTS
          WHERE REFERENCE_TABLE = 'FEEDS'
            AND PARENT_ID IS NULL
        ) TT5
        WHERE TT5.RANK <= 1
    ) T5 ON T1.ID = T5.REFERENCE_ID   
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
    AUTHOR_ID UUID,
    AUTHOR_USERNAME TEXT,
    AUTHOR_AVATAR_URL TEXT,
    IS_LIKE BOOLEAN,
    IKE_COUNT INT
)
language sql
as $$
    select
        T1.ID ID, 
        T1.CAPTION CAPTION, 
        T1.VIDEO VIDEO, 
        T1.CREATED_AT CREATED_AT, 
        T1.UPDATED_AT UPDATED_AT, 
        T1.CREATED_BY AUTHOR_ID, 
        T2.USERNAME AUTHOR_USERNAME, 
        T2.AVATAR_URL AUTHOR_AVATAR_URL,
        (T3.REFERENCE_ID IS NOT NULL) IS_LIKE,
        T4.LIKE_COUNT LIKE_COUNT
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
    LEFT JOIN (
        SELECT 
            REFERENCE_ID,
            EMOTION
        FROM PUBLIC.EMOTIONS
        WHERE REFERENCE_TABLE = 'REELS'
            AND EMOTION = 'LIKES'
            AND CREATED_BY = AUTH.UID()
    ) T3 ON T1.ID = T3.REFERENCE_ID
    LEFT JOIN (
        SELECT
            REFERENCE_ID,
            COUNT(1) LIKE_COUNT
        FROM PUBLIC.EMOTIONS
        WHERE REFERENCE_TABLE = 'REELS'
            AND EMOTION = 'LIKES'
        GROUP BY REFERENCE_ID
    ) T4 ON T1.ID = T4.REFERENCE_ID
;
$$

-----------------------------------------------------

CREATE OR REPLACE FUNCTION fetch_parent_comments(
    _before_at timestamptz, 
    _reference_id uuid,
    _reference_table text,
    _take int
)
RETURNS TABLE(
    ID UUID,
    CONTENT TEXT,
    CREATED_AT TIMESTAMPTZ,
    UPDATED_AT TIMESTAMPTZ,
    AUTHOR_ID UUID,
    AUTHOR_USERNAME TEXT,
    AUTHOR_AVATAR_URL TEXT,
    IS_LIKE BOOLEAN,
    LIKE_COUNT INT,
    CHILD_COUNT INT
)
language sql
as $$
    SELECT
        T1.ID ID,
        T1.CONTENT CONTENT,
        T1.CREATED_AT CREATED_AT,
        T1.UPDATED_AT UPDATED_AT,
        T1.CREATED_BY AUTHOR_ID,
        T2.USERNAME AUTHOR_USERNAME,
        T2.AVATAR_URL AUTHOR_AVATAR_URL,
        (T3.EMOTION IS NOT NULL) IS_LIKE,
        T4.LIKE_COUNT LIKE_COUNT,
        T5.CHILD_COUNT CHILD_COUNT
    FROM (
        SELECT
            ID,
            CONTENT,
            CREATED_AT,
            UPDATED_AT,
            CREATED_BY
        FROM
            PUBLIC.COMMENTS
        WHERE
            CREATED_AT < _before_at
            AND DELETED_AT IS NULL
            AND REFERENCE_ID = _reference_id
            AND REFERENCE_TABLE = _reference_table
            AND PARENT_ID IS NULL
        ORDER BY CREATED_AT DESC
        LIMIT(_take)
        ) T1
    LEFT JOIN PUBLIC.ACCOUNTS T2 
        ON T1.CREATED_BY = T2.ID
    LEFT JOIN (
        SELECT 
            REFERENCE_ID,
            EMOTION
        FROM PUBLIC.EMOTIONS
        WHERE REFERENCE_TABLE = 'COMMENTS'
            AND EMOTION = 'LIKES'
            AND CREATED_BY = AUTH.UID()
    ) T3 ON T1.ID = T3.REFERENCE_ID
    LEFT JOIN (
        SELECT
            REFERENCE_ID,
            COUNT(1) LIKE_COUNT
        FROM PUBLIC.EMOTIONS
        WHERE REFERENCE_TABLE = 'COMMENTS'
            AND EMOTION = 'LIKES'
        GROUP BY REFERENCE_ID
    ) T4 ON T1.ID = T4.REFERENCE_ID
    LEFT JOIN (
        SELECT
            PARENT_ID,
            COUNT(1) CHILD_COUNT
        FROM PUBLIC.COMMENTS
        WHERE PARENT_ID IS NOT NULL
            AND DELETED_AT IS NULL
            AND REFERENCE_ID = _reference_id
            AND REFERENCE_TABLE = _reference_table
        GROUP BY PARENT_ID
    ) T5 ON T1.ID = T5.PARENT_ID
;
$$

-----------------------------------------------------

CREATE OR REPLACE FUNCTION fetch_child_comments(
    _before_at timestamptz, 
    _reference_id uuid,
    _reference_table text,
    _parent_id uuid,
    _take int
)
RETURNS TABLE(
    ID UUID,
    CONTENT TEXT,
    CREATED_AT TIMESTAMPTZ,
    UPDATED_AT TIMESTAMPTZ,
    AUTHOR_ID UUID,
    AUTHOR_USERNAME TEXT,
    AUTHOR_AVATAR_URL TEXT,
    IS_LIKE BOOLEAN,
    LIKE_COUNT INT
)
language sql
as $$
    SELECT
        T1.ID ID,
        T1.CONTENT CONTENT,
        T1.CREATED_AT CREATED_AT,
        T1.UPDATED_AT UPDATED_AT,
        T1.CREATED_BY AUTHOR_ID,
        T2.USERNAME AUTHOR_USERNAME,
        T2.AVATAR_URL AUTHOR_AVATAR_URL,
        (T3.EMOTION IS NOT NULL) IS_LIKE,
        T4.LIKE_COUNT LIKE_COUNT
    FROM (
        SELECT
            ID,
            CONTENT,
            CREATED_AT,
            UPDATED_AT,
            CREATED_BY
        FROM
            PUBLIC.COMMENTS
        WHERE
            CREATED_AT < _before_at
            AND DELETED_AT IS NULL
            AND REFERENCE_ID = _reference_id
            AND REFERENCE_TABLE = _reference_table
        ORDER BY CREATED_AT DESC
        LIMIT(_take)
        ) T1
    LEFT JOIN PUBLIC.ACCOUNTS T2 
        ON T1.CREATED_BY = T2.ID
    LEFT JOIN (
        SELECT 
            REFERENCE_ID,
            EMOTION
        FROM PUBLIC.EMOTIONS
        WHERE REFERENCE_TABLE = 'COMMENTS'
            AND EMOTION = 'LIKES'
            AND CREATED_BY = AUTH.UID()
    ) T3 ON T1.ID = T3.REFERENCE_ID
    LEFT JOIN (
        SELECT
            REFERENCE_ID,
            COUNT(1) LIKE_COUNT
        FROM PUBLIC.EMOTIONS
        WHERE REFERENCE_TABLE = 'COMMENTS'
            AND EMOTION = 'LIKES'
        GROUP BY REFERENCE_ID
    ) T4 ON T1.ID = T4.REFERENCE_ID
;
$$
```