import { NextApiRequest, NextApiResponse } from "next";
import prisma from "../../../../../prisma/prisma_client";
import CommentModel from "@/data/model/comment_model";

interface ResponseProps {
    comments: CommentModel[];
    message: string;
}

/// 부모 댓글 목록 조회
export default async function GET(req: NextApiRequest, res: NextApiResponse<ResponseProps>) {
    try {

        // 파라메터
        const postId = req.query.postId as string
        const page = parseInt(req.query.page as string) || 1;
        const pageSize = parseInt(req.query.pageSize as string) || 10;
        const skip = (page - 1) * pageSize

        // 데이터 조회
        const comments = (await prisma.comment.findMany({
            where: {
                postId,
                isParent: true
            },
            skip,
            take: pageSize,
            orderBy: {
                createdAt: 'desc',
            }
        })).map((c) => ({
            postId: c.postId,
            parentId: undefined,
            content: c.content,
            authorId: c.authorId,
            createdAt: c.createdAt,
            type: "parent"
        } as CommentModel))

        res.status(200).json({ comments, message: 'success to get parent comments' })
    } catch {
        res.status(500).json({ comments: [], message: 'success to get parent comments' })
    }
}