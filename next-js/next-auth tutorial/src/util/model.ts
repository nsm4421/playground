export type ArticleModel = {
  id: number;
  createdAt: string;
  updatedAt: string;
  title: string;
  content: string;
  published: boolean;
  author: String;
  location: String;
  hashtags: string[];
};
