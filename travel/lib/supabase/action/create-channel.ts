import createSupabaseBrowerCleint from "../client/browser-client";

export function createCommentChannel({
  postId,
  callback,
}: {
  postId: string;
  callback: (payload: any) => void;
}) {
  const supabase = createSupabaseBrowerCleint();
  return supabase
    .channel(`post-comment-${postId}`)
    .on(
      "postgres_changes",
      {
        event: "INSERT",
        schema: "public",
        table: "post_comments",
      },
      callback
    )
    .subscribe();
}
