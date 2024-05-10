"use server";

import { createBrowserClient } from "@supabase/ssr";
import { cookies } from "next/headers";

export const supabaseServer = () => {
  const cookieStore = cookies();

  const browswer = createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_KEY!,
    {
      cookies: {
        get(name: string) {
          return cookieStore.get(name)?.value;
        },
      },
    }
  );
};
