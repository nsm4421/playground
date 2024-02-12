import { NextApiRequest, NextApiResponse } from "next";
import CommentModel from "@/data/model/comment_model";
import prisma from "../../../../../../prisma/prisma_client";

interface ResponseProps {
    comments: CommentModel[];
    message: string;
}

/// 자식 댓글 목록 조회
export default async function GET(req: NextApiRequest, res: NextApiResponse<ResponseProps>) {
    try {

        // 파라메터
        const parentId = req.query.parentId as string
        const page = parseInt(req.query.page as string) || 1;
        const pageSize = parseInt(req.query.pageSize as string) || 10;
        const skip = (page - 1) * pageSize

        // 자식 댓글 조회
        const comments = (await prisma.comment.findMany({
            where: {
                parentId,
                isParent: false
            },
            skip,
            take: pageSize,
            orderBy: {
                createdAt: 'desc',
            }
        })).map((c) => ({
            postId: c.postId,
            parentId: parentId,
            content: c.content,
            authorId: c.authorId,
            createdAt: c.createdAt,
            type: "child"
        } as CommentModel))

        res.status(200).json({ comments, message: 'success to get child comments' })
    } catch {
        res.status(500).json({ comments: [], message: 'success to get child comments' })
    }
}