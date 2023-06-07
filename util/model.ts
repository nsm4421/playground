export type PostData = {
  _id: string;
  title?: string;
  content?: string;
  email?: string;
};

export type WritePostData = {
  title: string;
  content: string;
};

export type EditPostData = {
  _id: string;
  title: string;
  content: string;
};

export type RegisterRequest = {
  email: string;
  password: string;
};

export type CommentData = {
  _id: string;      // comment id
  userId: string;   
  postId: string;
  nickname: string;
  content: string;
  createdAt?: string;
  updatedAt?: string;
};

export type ROLE = "USER" | "MANGER" | "ADMIN";
