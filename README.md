# Prisma

    npm i pusher-js pusher next-auth @auth/prisma-adapter @prisma/client

    npm i -D prisma

    npx prisma init

# Type Generation

Reference

    https://supabase.com/docs/guides/api/rest/generating-types

Script

`npx supabase gen types typescript --project-id "ardjcobuvldtslcgbmxr" --schema public > lib/supabase/types.ts`


# Sign Up

BEGIN
INSERT INTO public.users (id, email, username, avatar_url)
VALUES (NEW.id, NEW.email, NEW.raw_user_meta_data->>'name', NEW.raw_user_meta_data->>'avatar_url');
RETURN NEW;
END;
