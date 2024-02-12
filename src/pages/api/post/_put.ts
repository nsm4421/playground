import { NextApiRequest, NextApiResponse } from "next"
import { getServerSession } from "next-auth"
import { authOptions } from "../auth/[...nextauth]"
import prisma from "../../../../prisma/prisma_client"

interface RequestProps {
    postId: string
    content: string
    images: string[]
    hashtags: string[]
}

interface ResponseProps {
    message: string
}

export default async function PUT(req: NextApiRequest, res: NextApiResponse<ResponseProps>) {
    try {
        // 로그인 여부 검사
        const session = await getServerSession(req, res, authOptions)
        if (!session) {
            res.status(401).json({ message: '인증되지 않은 사용자입니다' })
            return
        }

        // 포스팅 존재여부 검사
        const { postId, content, hashtags, images }: RequestProps = req.body
        const post = await prisma.post.findUniqueOrThrow({
            where: {
                id: postId
            }
        })

        // 수정요청한 사람과 작성자가 동일한지 확인
        if (post.authorId !== session.user.id) {
            console.error("다른 사람이 작성한 게시글을 수정하려고 하려는 요청")
            res.status(403).json({ message: 'forbidden request for modifying post' })
            return
        }

        // 포스팅 수정
        await prisma.post.update({
            where: {
                id: postId
            }, data: {
                content, hashtags, images
            }
        })

        res.status(200).json({ message: 'success to update post' })
    } catch (err) {
        console.error(err)
        res.status(500).json({ message: 'internal server error' })
    }
}