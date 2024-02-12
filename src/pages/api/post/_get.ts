import { NextApiRequest, NextApiResponse } from "next"
import prisma from "../../../../prisma/prisma_client"
import PostModel from "@/data/model/post_model"

interface ResponseType {
    posts: PostModel[],
    message: string
}

export default async function GET(req: NextApiRequest, res: NextApiResponse<ResponseType>) {
    try {
        // 페이징 처리
        const page = parseInt(req.query.page as string) || 1
        const pageSize = parseInt(req.query.pageSize as string) || 10
        const skip = (page - 1) * pageSize

        // 포스팅 페이지 조회
        const posts: PostModel[] = (await prisma.post.findMany({
            skip,
            take: pageSize,
            orderBy: {
                createdAt: 'desc',
            }
        })).map(post => ({
            id: post.id,
            content: post.content,
            hashtags: post.hashtags,
            images: post.images,
            placeId: post.placeId,
            authorId: post.authorId,
            createdAt: post.createdAt
        } as PostModel))

        res.status(200).json({ posts, message: "success to get posts" })
    } catch (err) {
        res.status(500).json({ posts: [], message: "internal server error" })
    }
}