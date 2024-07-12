export default interface CommentModel {
    postId: string;
    parentId? : string;
    content: string;
    authorId: string;
    createdAt: Date;
    type: CommentType
}

export type CommentType = "parent" | "child"