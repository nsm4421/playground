```
CREATE OR REPLACE FUNCTION PUBLIC."ON_SIGN_UP"()
RETURNS TRIGGER
LANGUAGE PLPGSQL
SECURITY DEFINER SET SEARCH_PATH = PUBLIC
AS $$
    BEGIN
    INSERT INTO PUBLIC."ACCOUNTS" (
        ID,
        EMAIL, 
        USERNAME, 
        AVATAR_URL
    )
    VALUES (
        NEW.ID, 
        NEW.EMAIL,
        NEW.RAW_USER_META_DATA->>'username', 
        NEW.RAW_USER_META_DATA->>'avatar_url'
    );
    RETURN NEW;
    END;
$$;

-----------------------------------------------------

CREATE TRIGGER ON_AUTH_USER_CREATED
AFTER INSERT ON AUTH.USERS
FOR EACH ROW EXECUTE PROCEDURE PUBLIC."ON_SIGN_UP"();

-----------------------------------------------------

CREATE OR REPLACE FUNCTION fetch_feeds(
    _search_field text,
    _search_text text,
    _before_at timestamptz, 
    _take int
)
RETURNS TABLE(
    ID UUID,
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
            HASHTAGS,
            IMAGES,
            CAPTIONS,
            CREATED_AT,
            UPDATED_AT,
            CREATED_BY
        FROM
            PUBLIC."FEEDS"
        WHERE
            CREATED_AT < _before_at
            AND DELETED_AT IS NULL
            AND (
                _search_field IS NULL OR (
                    _search_field = 'HASHTAGS' AND (
                        exists (
                            SELECT 1
                            FROM UNNEST("FEEDS".HASHTAGS) AS TAG
                            WHERE TAG LIKE '%' || _search_text || '%'
                        )
                    )
                ) OR (
                    _search_field = 'CAPTIONS' AND (
                        exists (
                            SELECT 1
                            FROM UNNEST("FEEDS".CAPTIONS) AS CAP
                            WHERE CAP LIKE '%' || _search_text || '%'
                        )
                    )
                ) OR (
                    _search_field = 'USER' AND "FEEDS".CREATED_BY::TEXT = _search_text
                )
            )
        ORDER BY CREATED_AT DESC
        LIMIT(_take)
        ) T1
    LEFT JOIN PUBLIC."ACCOUNTS" T2 
        ON T1.CREATED_BY = T2.ID
    LEFT JOIN (
        SELECT 
            REFERENCE_ID,
            EMOTION
        FROM PUBLIC."EMOTIONS"
        WHERE REFERENCE_TABLE = 'FEEDS'
            AND EMOTION = 'LIKES'
            AND CREATED_BY = AUTH.UID()
    ) T3 ON T1.ID = T3.REFERENCE_ID
    LEFT JOIN (
        SELECT
            REFERENCE_ID,
            COUNT(1) LIKE_COUNT
        FROM PUBLIC."EMOTIONS"
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
          FROM PUBLIC."COMMENTS"
          WHERE REFERENCE_TABLE = 'FEEDS'
            AND PARENT_ID IS NULL
        ) TT5
        WHERE TT5.RANK <= 1
    ) T5 ON T1.ID = T5.REFERENCE_ID   
;
$$

-----------------------------------------------------

CREATE OR REPLACE FUNCTION FETCH_REELS(_BEFORE_AT TIMESTAMPTZ, _TAKE INT)
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
LANGUAGE SQL
AS $$
    SELECT
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
            PUBLIC."REELS"
        WHERE
            CREATED_AT < _BEFORE_AT
            AND DELETED_AT IS NULL
        ORDER BY CREATED_AT DESC
        LIMIT(_TAKE)
        ) T1
    LEFT JOIN PUBLIC."ACCOUNTS" T2
        ON T1.CREATED_BY = T2.ID
    LEFT JOIN (
        SELECT 
            REFERENCE_ID,
            EMOTION
        FROM PUBLIC."EMOTIONS"
        WHERE REFERENCE_TABLE = 'REELS'
            AND EMOTION = 'LIKES'
            AND CREATED_BY = AUTH.UID()
    ) T3 ON T1.ID = T3.REFERENCE_ID
    LEFT JOIN (
        SELECT
            REFERENCE_ID,
            COUNT(1) LIKE_COUNT
        FROM PUBLIC."EMOTIONS"
        WHERE REFERENCE_TABLE = 'REELS'
            AND EMOTION = 'LIKES'
        GROUP BY REFERENCE_ID
    ) T4 ON T1.ID = T4.REFERENCE_ID
;
$$

-----------------------------------------------------

CREATE OR REPLACE FUNCTION FETCH_PARENT_COMMENTS(
    _BEFORE_AT TIMESTAMPTZ, 
    _REFERENCE_ID UUID,
    _REFERENCE_TABLE TEXT,
    _TAKE INT
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
LANGUAGE SQL
AS $$
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
            PUBLIC."COMMENTS"
        WHERE
            CREATED_AT < _BEFORE_AT
            AND DELETED_AT IS NULL
            AND REFERENCE_ID = _REFERENCE_ID
            AND REFERENCE_TABLE = _REFERENCE_TABLE
            AND PARENT_ID IS NULL
        ORDER BY CREATED_AT DESC
        LIMIT(_TAKE)
        ) T1
    LEFT JOIN PUBLIC."ACCOUNTS" T2 
        ON T1.CREATED_BY = T2.ID
    LEFT JOIN (
        SELECT 
            REFERENCE_ID,
            EMOTION
        FROM PUBLIC."EMOTIONS"
        WHERE REFERENCE_TABLE = 'COMMENTS'
            AND EMOTION = 'LIKES'
            AND CREATED_BY = AUTH.UID()
    ) T3 ON T1.ID = T3.REFERENCE_ID
    LEFT JOIN (
        SELECT
            REFERENCE_ID,
            COUNT(1) LIKE_COUNT
        FROM PUBLIC."EMOTIONS"
        WHERE REFERENCE_TABLE = 'COMMENTS'
            AND EMOTION = 'LIKES'
        GROUP BY REFERENCE_ID
    ) T4 ON T1.ID = T4.REFERENCE_ID
    LEFT JOIN (
        SELECT
            PARENT_ID,
            COUNT(1) CHILD_COUNT
        FROM PUBLIC."COMMENTS"
        WHERE PARENT_ID IS NOT NULL
            AND DELETED_AT IS NULL
            AND REFERENCE_ID = _REFERENCE_ID
            AND REFERENCE_TABLE = _REFERENCE_TABLE
        GROUP BY PARENT_ID
    ) T5 ON T1.ID = T5.PARENT_ID
;
$$

-----------------------------------------------------

CREATE OR REPLACE FUNCTION FETCH_CHILD_COMMENTS(
    _BEFORE_AT TIMESTAMPTZ, 
    _REFERENCE_ID UUID,
    _REFERENCE_TABLE TEXT,
    _PARENT_ID UUID,
    _TAKE INT
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
LANGUAGE SQL
AS $$
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
            PUBLIC."COMMENTS"
        WHERE
            CREATED_AT < _BEFORE_AT
            AND DELETED_AT IS NULL
            AND REFERENCE_ID = _REFERENCE_ID
            AND REFERENCE_TABLE = _REFERENCE_TABLE
        ORDER BY CREATED_AT DESC
        LIMIT(_TAKE)
        ) T1
    LEFT JOIN PUBLIC."ACCOUNTS" T2 
        ON T1.CREATED_BY = T2.ID
    LEFT JOIN (
        SELECT 
            REFERENCE_ID,
            EMOTION
        FROM PUBLIC."EMOTIONS"
        WHERE REFERENCE_TABLE = 'COMMENTS'
            AND EMOTION = 'LIKES'
            AND CREATED_BY = AUTH.UID()
    ) T3 ON T1.ID = T3.REFERENCE_ID
    LEFT JOIN (
        SELECT
            REFERENCE_ID,
            COUNT(1) LIKE_COUNT
        FROM PUBLIC."EMOTIONS"
        WHERE REFERENCE_TABLE = 'COMMENTS'
            AND EMOTION = 'LIKES'
        GROUP BY REFERENCE_ID
    ) T4 ON T1.ID = T4.REFERENCE_ID
;
$$
```