import createSupabaseBrowerCleint from "../client/browser-client";

export default async function getCurrentUser() {
  const supabase = createSupabaseBrowerCleint();

  return await supabase.auth
    .getUser()
    .then((res) => res.data.user)
}
