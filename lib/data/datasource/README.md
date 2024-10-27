# Rpc Function

## Auth

### 회원가입

- on_sign_up

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
```

- on_auth_user_created

```
create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.on_sign_up();
```

### 회원정보 수정

- on_edit_profile


```
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
```

## Diary

- fetch_diaries

```
create or replace function fetch_diaries
(_before_at timestamptz, _take int)
returns table(
    id uuid, 
    images text[],
    hashtags text[],
    captions text[],
    location text,
    content text,
    is_private bool,
    is_like bool,
    like_count int,
    comment_count int,
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
      (SELECT EXISTS (
        SELECT 1
        FROM public.likes
        WHERE created_by = auth.uid() 
        AND reference_table = 'diaries'
        AND reference_id = A.id
      )) AS is_like,
      (
        SELECT count(1)
        FROM public.likes
        WHERE reference_table = 'diaries'
        AND reference_id = A.id
      ) AS like_count,     
      (
        select count(1)
        from public.comments
        WHERE reference_table = 'diaries'
        AND reference_id = A.id
      ) AS comment_count,
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
            created_at < _before_at
            and ((is_private = false) or (created_by = auth.uid()))
        order by created_at desc
        limit(_take)
        ) A
    left join public.accounts B on A.created_by = B.id
;
$$
```

## Meeting

- fetch_meetings

```
create or replace function fetch_meetings
(_before_at timestamptz, _take int)
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
            created_at < _before_at
        order by created_at desc
        limit(_take)
        ) A
    left join public.accounts B on A.created_by = B.id
;
$$
```

## Registrations

- create_registration

```
CREATE OR REPLACE FUNCTION create_registration(
    _meeting_id uuid,
    _introduce text
)
RETURNS UUID AS $$
DECLARE
    _max_permiteed_head_count int;                  
    _current_permitted_head_count int;
    _manager_id uuid;
    _registration_id uuid;
BEGIN
    SELECT head_count, created_by 
    INTO _max_permiteed_head_count, _manager_id
    FROM meetings
    WHERE id = _meeting_id;
    
    SELECT count(1) 
    INTO _current_permitted_head_count
    FROM registrations
    WHERE meeting_id = _meeting_id
    and is_permitted = true;
 

    IF not found then
        RAISE EXCEPTION 'meeting with id % does not exist', _meeting_id;
    ELSIF _max_permiteed_head_count <= _current_permitted_head_count then
        RAISE EXCEPTION 'head count can not exceed %', _max_permiteed_head_count;
    end IF;

    INSERT INTO registrations (
        meeting_id,
        manager_id,
        proposer_id,
        is_permitted,
        introduce,
        created_by,
        created_at,
        updated_at
    ) VALUES (
        _meeting_id,
        _manager_id,
        auth.uid(),
        _manager_id = auth.uid(),
        _introduce,
        auth.uid(),
        NOW() AT TIME ZONE 'UTC',
        NOW() AT TIME ZONE 'UTC'
    )
    RETURNING id INTO _registration_id;
    RETURN _registration_id;
END;
$$ LANGUAGE plpgsql;
```

- fetch_registrations

```
CREATE OR REPLACE FUNCTION fetch_registrations(_meeting_id uuid)
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
    INTRODUCE text,
    CREATED_AT timestamptz
)
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        R.ID,                            
        R.MEETING_ID,                   
        R.MANAGER_ID,
        MGR.USERNAME AS MANAGER_USERNAME,
        MGR.AVATAR_URL AS MANAGER_AVATAR_URL,
        R.CREATED_BY,                  
        R.PROPOSER_ID,              
        PRP.USERNAME AS PROPOSER_USERNAME, 
        PRP.AVATAR_URL AS PROPOSER_AVATAR_URL,
        R.IS_PERMITTED,           
        R.INTRODUCE,            
        R.CREATED_AT
    FROM public.REGISTRATIONS R
    LEFT JOIN public.ACCOUNTS PRP ON R.PROPOSER_ID = PRP.ID
    LEFT JOIN public.ACCOUNTS MGR ON R.MANAGER_ID = MGR.ID
    where R.MEETING_ID = _meeting_id;
END;
$$ LANGUAGE plpgsql;
```

- ON_MEETING_CREATED

```
CREATE OR REPLACE FUNCTION PUBLIC.ON_MEETING_CREATED()
returns trigger
language plpgsql
security definer set search_path = public
as $$
    begin
    PERFORM create_registration(NEW.ID, 'meeting created');
    RETURN NEW;
    end;
$$;

create trigger on_meeting_created
after insert on public.meetings
for each row execute procedure PUBLIC.ON_MEETING_CREATED();
```

## Comments

- fetch_comments
```
CREATE OR REPLACE FUNCTION fetch_comments(
    _reference_id uuid,
    _reference_table text,
    _before_at timestamptz, 
    _take int
) RETURNS table(
    id uuid,
    reference_table text,
    reference_id UUID,
    content text,
    author_uid uuid,
    author_username text,
    author_avatar_url text,
    created_at timestamptz,
    updated_at timestamptz
)
language sql
as $$
    select
        A.id,
        A.reference_table,
        A.reference_id,
        A.content,
        A.created_by author_uid,
        B.username author_username,
        B.avatar_url author_avatar_url,
        A.created_at,
        A.updated_at
    from (
        select
            id,
            reference_table,
            reference_id,
            content,
            created_by,
            created_at,
            updated_at
        from
            public.comments
        where
            created_at < _before_at
            and reference_table = _reference_table
            and reference_id = _reference_id
        order by created_at desc
        limit(_take)
        ) A
    left join public.accounts B on A.created_by = B.id;
$$
```

- update_permission_on_registration
```
CREATE OR REPLACE FUNCTION update_permission_on_registration(
    _registration_id uuid,
    _is_permitted bool
)
RETURNS void AS $$
DECLARE
    _updated_count int;
    max_head_count int;
    _permitted_head_count int;
    _meeting_id_ uuid;
    _manager_id uuid;
BEGIN
    SELECT meeting_id, manager_id 
    INTO _meeting_id_, _manager_id
    FROM registrations
    WHERE id = _registration_id;   
    
    -- 권한 체크
    IF _manager_id != auth.uid() then
        RAISE EXCEPTION 'only manager can handle permission';
    -- 변경할 record가 없는 경우
    ELSIF not found then
        RAISE EXCEPTION 'registration with id % does not exist', _registration_id;
    -- 동행 허용하는 경우 최대 인원수 초과하는지 확인
    ELSIF _is_permitted then
        SELECT count(1) 
        INTO _permitted_head_count
        FROM registrations
        WHERE meeting_id = _meeting_id_ and is_permitted = true;        
        SELECT head_count
        INTO max_head_count
        FROM meetings
        WHERE id = _meeting_id_;
        IF max_head_count <= _permitted_head_count then
            RAISE EXCEPTION 'head count can not exceed %', max_head_count;
        END IF;
    END IF;
    
    -- 업데이트
    update public.registrations 
    set is_permitted = _is_permitted,
    updated_at = NOW()
    where id = _registration_id;
    
    -- 업데이트 결과 체크
    GET DIAGNOSTICS _updated_count = ROW_COUNT;
    IF _updated_count = 0 then
        RAISE EXCEPTION 'updated nothing';       
    ELSIF _updated_count > 1 then
        RAISE EXCEPTION 'attempt to update % rows', _updated_count;
    END IF;
END;
$$ LANGUAGE plpgsql;
```