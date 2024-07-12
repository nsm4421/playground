import { NextApiRequest, NextApiResponse } from "next"
import { getServerSession } from "next-auth"
import { authOptions } from "../auth/[...nextauth]"
import prisma from "../../../../prisma/prisma_client"

export default async function DELETE(req: NextApiRequest, res: NextApiResponse) {

    try {
        // 로그인 여부 검사
        const session = await getServerSession(req, res, authOptions)
        if (!session) {
            res.status(401).json({ message: '인증되지 않은 사용자입니다' })
            return
        }

        // 포스팅 조회
        const postId = req.query.postId as string
        const post = await prisma.post.findUniqueOrThrow({
            where: {
                id: postId
            }
        })

        // 권한 체크
        if (post.authorId !== session.user.id) {
            res.status(403).json({ message: 'forbidden request for delete post' })
            return
        }

        // 포스팅 삭제
        await prisma.post.delete({
            where: {
                id: postId
            },
        })

        res.status(200).json({ message: "success to delete post" })
    } catch (err) {
        // 에러처리
        res.status(500).json({ message: "internal server error" })
    }
}