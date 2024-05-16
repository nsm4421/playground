"use client";

import createSupabaseBrowerCleint from "@/lib/supabase/client/browser-client";
import { Auth } from "@supabase/auth-ui-react";

import {
  // Import predefined theme
  ThemeSupa,
} from "@supabase/auth-ui-shared";

export default function AuthForm() {
  const supabase = createSupabaseBrowerCleint();
  return (
    <main>
      <Auth
        supabaseClient={supabase}
        appearance={{ theme: ThemeSupa }}
        providers={["google", "github"]}
      />
    </main>
  );
}
