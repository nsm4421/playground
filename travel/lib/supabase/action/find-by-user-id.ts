import createSupabaseBrowerCleint from "../client/browser-client";

interface Props {
  userId: string;
}

export default async function findByUserId({ userId }: Props) {
  const supabase = createSupabaseBrowerCleint();
  return await supabase
    .from("users")
    .select()
    .eq("id", userId)
    .single()
    .then((res) => res.data);
}
