export type SearchType = "TITLE" | "CONTENT" | "HASHTAG" | "USER" | null;
export type SortField = "TITLE" | null;
export type Direction = "ASC" | "DESC" | null;
export type Emotion = "LIKE" | "DISLIKE" | null;
export type EmtoionCountMap = {
  LIKE: number;
  DISLIKE: number;
} | null;
export type Article = {
  id: Number;
  title: string;
  content: string;
  hashtags: Set<string>;
  createdAt: string;
  createdBy: string;
  modifiedAt: string;
};
export type Comment = {
  id: number;
  articleId: number;
  username: string;
  parentCommentId: number | null;
  content: string;
  createdAt: string;
  createdBy: string;
};
export type AlarmType = "NEW_EMOTION_ON_ARTICLE" | "NEW_COMMENT_ON_ARTICLE";
export type Alarm = {
  id: number;
  alarmType: AlarmType;
  message: string;
  memo: string;
  createdAt: string;
};
export type AlarmMemo = {
  articleId?: number;
  commentId?: number;
  parentCommentId?: number;
  title:string;
  comment? : string;
  emotion?:Emotion
  username?: string;
  alarmType: AlarmType;
  createdAt?:string;
};
