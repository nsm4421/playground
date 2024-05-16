import createSupabaseBrowerCleint from "../client/browser-client";

export default async function getCurrentUser() {
  const supbase = createSupabaseBrowerCleint();

  return await supbase.auth
    .getUser()
    .then((res) => res.data.user)
}
