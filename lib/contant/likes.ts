export type LikeReferenceType = "post" | "post_comment";

export type Like = {
  id: string;
  created_by: string;
  reference_type: LikeReferenceType;
};
