import { createBrowserClient } from "@supabase/ssr";

const getSupbaseBrowser = () =>
  createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
  );

export default getSupbaseBrowser;
