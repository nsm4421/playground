export type Post = {
  id: string;
  content: string | null;
  hashtags: string[];
  images: string[];
  created_by: string | null;
  created_at: string;
};

export type PostComment = {
  id: string;
  post_id: string;
  content: string;
  created_by: string;
  created_at: string;
};

export type PostWithAuthor = Post & {
  author: {
    id:string;
    nickname: string;
    profile_image: string;
  };
};

export type PostCommentWithAuthor = PostComment & {
  author: {
    id:string;
    nickname: string;
    profile_image: string;
  };
};
