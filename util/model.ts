export type PostData = {
  postId: string;
  title?: string;
  content?: string;
  userId?: string;
  createdAt?: string;
  updatedAt?: string;
};

export type WritePostData = {
  title: string;
  content: string;
};

export type EditPostData = {
  postId: string;
  title: string;
  content: string;
};

export type RegisterRequest = {
  email: string;
  password: string;
};

export type CommentData = {
  commentId: string; // comment id
  userId: string;
  postId: string;
  nickname: string;
  content: string;
  createdAt?: string;
  updatedAt?: string;
};

export type ROLE = "USER" | "MANGER" | "ADMIN";
