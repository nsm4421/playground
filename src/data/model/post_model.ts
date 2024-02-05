interface PostModel {
    id: string;
    content: string;
    hashtags: string[];
    placeId: string | null;
    authorId: string;
    createdAt: Date;
}

export default PostModel;