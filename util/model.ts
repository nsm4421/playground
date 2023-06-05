export type PostData = {
  _id: string;
  title?: string;
  content?: string;
  email:string;
};

export type WritePostData = {
  title: string;
  content: string;
};

export type EditPostData = {
  _id : string;
  title: string;
  content: string;
};