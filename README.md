Private Chat Message Model

    Fields
    
    - id
    - chat_id  
    - sender
    - receiver
    - content
    - created_at

```
drop function if exists get_latest_private_chat_messages(timestamptz);

create or replace function get_latest_private_chat_messages(afterAt timestamptz)
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
            created_at >= afterAt
        ) A 
    join "accounts" B on A.sender = B.id
    join "accounts" C on A.receiver = C.id
    where A.rn <= 1
    order by A.created_at desc;
$$;
```


