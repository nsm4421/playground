import { NextApiRequest, NextApiResponse } from "next"
import prisma from "../../../../prisma/prisma_client"
import PostModel from "@/data/model/post_model";

interface ResponseType {
    posts: PostModel[],
    message: string
}

export default async function GET(req: NextApiRequest, res: NextApiResponse<ResponseType>) {
    try {
        // 페이징 처리
        const page = parseInt(req.query.page as string) || 1;
        const pageSize = parseInt(req.query.pageSize as string) || 10;
        const skip = (page - 1) * pageSize

        // 데이터 조회
        const posts = await prisma.post.findMany({
            skip,
            take: pageSize,
            orderBy: {
                createdAt: 'desc',
            }
        })
        
        res.status(200).json({ posts, message: "success to get posts" })
    } catch (err) {
        res.status(500).json({ posts: [], message: "internal server error" })
    } 
}