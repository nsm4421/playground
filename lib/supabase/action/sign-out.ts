import createSupabaseBrowerCleint from "../client/browser-client";

export default async function SignOutAction() {
  const supbase = createSupabaseBrowerCleint();

  return await supbase.auth.signOut();
}
