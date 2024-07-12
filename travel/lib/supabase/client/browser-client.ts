import { createBrowserClient } from "@supabase/ssr";
import { Database } from "../type/types";

export default function createSupabaseBrowerCleint() {
  return createBrowserClient<Database>(
    process.env.NEXT_PUBLIC_SUPABASE_URL as string,
    process.env.NEXT_PUBLIC_SUPABASE_KEY as string
  );
}
