# RPC

## Feed Model

    returns
    
    - id
    - content  
    - media
    - hashtags
    - author_id
    - author_nickname
    - author_profile_image
    - created_at
    - emotion_type
```
drop function if exists fetch_feeds(timestamptz, int);

create or replace function fetch_feeds(before_at timestamptz, take int)
returns table(
    id uuid, 
    content text, 
    media text[], 
    hashtags text[], 
    created_at timestamptz,
    author_id uuid, 
    author_nickname text, 
    author_profile_image text, 
    emotion_id text,
    emotion_type text
)
language sql
as $$
    select
        A.id as feed_id,
        A.content as content,
        A.media as media,
        A.hashtags as hashtags,
        A.created_at as created_at,
        B.id as author_id,
        B.nickname as author_nickname,
        B.profile_image as author_profile_image,
        C.id as emotion_id,
        C.type as emotion_type
    from (
            select * 
            from feeds 
            where created_at < before_at
        ) A 
        left join accounts B on A.created_by = B.id
        left join (
            select * 
            from emotions
            where reference_table = 'feeds' 
        ) C on A.created_by = C.created_by and A.id = C.reference_id
    order by A.created_at desc
    limit (take);
$$;
```

## Feed Comment Model

    returns
    
    - comment_id
    - feed_id
    - content  
    - author_id
    - author_nickname
    - author_profile_image
    - created_at
    - emotion_id
    - emotion_type
```
drop function if exists fetch_comments(uuid, timestamptz, int);

create or replace function fetch_comments(fid uuid, before_at timestamptz, take int)
returns table(
    id uuid,
    feed_id uuid, 
    content text, 
    created_at timestamptz,    
    author_id uuid, 
    author_nickname text, 
    author_profile_image text,     
    emotion_id text,
    emotion_type text 
)
language sql
as $$
    select
        A.id as id,
        A.feed_id as feed_id,
        A.content as content,
        A.created_at as created_at,
        B.id as author_id,
        B.nickname as author_nickname,
        B.profile_image as author_profile_image,
        C.id as emotion_id,
        C.type as emotion_type
    from (
            select *
            from feed_comments
            where created_at < before_at and fid = feed_id
        ) A left join accounts B on A.created_by = B.id
        left join (
            select *
            from emotions
            where reference_table = 'feed_comments'
        ) C on A.created_by = C.created_by and A.id = C.reference_id
    order by A.created_at desc
    limit(take);
$$;
```

## Private Chat Message Model

    returns
    
    - id
    - chat_id  
    - sender_uid
    - sender_nickname
    - sender_profile_image    
    - receiver_uid
    - receiver_nickname
    - receiver_profile_image
    - content
    - created_at

```
drop function if exists get_latest_private_chat_messages(timestamptz);

create or replace function get_latest_private_chat_messages(after_at timestamptz)
returns table(id uuid, chat_id text, sender_uid uuid, sender_nickname text, sender_profile_image text, receiver_uid uuid, receiver_nickname text, receiver_profile_image text, content text, created_at timestamptz)
language sql
as $$
    select
        A.id,
        A.chat_id,
        B.id as "sender_uid",
        B.nickname as "sender_nickname",
        B."profile_image" as "sender_profile_image",
        C.id as "receiver_uid",
        C.nickname as "receiver_nickname",
        C."profile_image" as "receiver_profile_image",
        A.content,
        A.created_at
    from (
        select
            id,
            chat_id,
            sender,
            receiver,
            content,
            created_at,
            row_number() over (partition by chat_id order by created_at desc) rn
        from
            "private_chat_messages"
        where
            created_at >= after_at
        ) A 
    join "accounts" B on A.sender = B.id
    join "accounts" C on A.receiver = C.id
    where A.rn <= 1
    order by A.created_at desc;
$$;
```
