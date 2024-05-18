# Authentication

- Clerk라이브러리를 사용해 소셜 로그인 구현

- 설치

    `npm install @clerk/nextjs`

# Design

- Tailwind

- Next UI

    `npm install -g nextui-cli`

    `nextui add --all`

# Supabase

- Install

    `npm install @supabase/ssr @supabase/supabase-js`

    `npx supabase gen types typescript --project-id "gybcttbxvzbtohwrmqdc" --schema public > lib/supabase/type/types.ts`

- Auth Setting

    - 유저 테이블 생성

        `create table users (
            id uuid references auth.users not null primary key,
            email text not null,
            nickname text not null,
            profile_image text not null,
            created_at timestamp default current_timestamp);`

    -  user 테이블 RLS 활성화

        `alter table users enable row level security;`

    - 권한 설정 : 자기 자신의 데이터만 생성 및 수정 가능

        `create policy "user can only insert own data" on users for insert
        with check (auth.uid () = id);
        create policy "user can only update own data" on users for update
        with check (auth.uid () = id);
        `

    - 회원가입 이벤트 정의

        ```
         CREATE FUNCTION public.on_auth_user_created_func()
            RETURNS trigger AS $$
            DECLARE
                PROVIDER VARCHAR :='';          -- github, google
                NICKNAME VARCHAR :='';          -- 초기 닉네임
                AVATAR_URL VARCHAR := '';       -- 초기 프로필 이미지
            BEGIN
                select NEW.raw_app_meta_data->>'provider' into PROVIDER from auth.users;

                IF PROVIDER = 'google' then
                    NICKNAME = NEW.raw_user_meta_data->>'name';
                    AVATAR_URL = NEW.raw_user_meta_data->>'avatar_url';
                ELSIF PROVIDER = 'github' then
                    NICKNAME = NEW.raw_user_meta_data->>'user_name';
                    AVATAR_URL = NEW.raw_user_meta_data->>'avatar_url';       
                END IF;

                UPDATE auth.users 
                SET
                    raw_user_meta_data = jsonb_set(
                        jsonb_set(raw_user_meta_data, '{nickname}', to_jsonb(NICKNAME), true),
                        '{profile_image}', to_jsonb(AVATAR_URL), true
                    )
                WHERE id = NEW.id;

                INSERT INTO public.users (id, email, nickname, profile_image)
                VALUES (NEW.id, NEW.email, NICKNAME, AVATAR_URL);

                RETURN NEW;
            END;
        $$ LANGUAGE plpgsql SECURITY DEFINER;

    - auth.users테이블에 insert 되는 경우(회원가입 성공시), 이벤트(on_auth_user_created_func)를 발생시킬 트리거(on_auth_user_created_trigger) 정의

        `
        CREATE TRIGGER on_auth_user_created_trigger
        AFTER INSERT ON auth.users
        FOR EACH ROW
        EXECUTE PROCEDURE public.on_auth_user_created_func();
        `
