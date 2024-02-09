interface PostModel {
    id: string;
    content: string;
    hashtags: string[];
    images: string[];
    placeId: string | null;
    authorId: string;
    createdAt: Date;
}

export default PostModel;