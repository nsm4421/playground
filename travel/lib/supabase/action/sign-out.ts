import createSupabaseBrowerCleint from "../client/browser-client";

export default async function SignOutAction() {
  const supabase = createSupabaseBrowerCleint();

  return await supabase.auth.signOut();
}
