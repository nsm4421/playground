import axios from "axios";
import { useEffect, useState } from "react";
import ApiRoute from "../constant/api_route";
import CommentModel from "@/data/model/comment_model";

interface ParentCommentProps {
    postId: string;
    page: number;
    pageSize: number;
}

interface ChildCommentProps {
    parentId: string;
    page: number;
    pageSize: number;
}

export function useParentComment({ postId, page, pageSize }: ParentCommentProps) {
    const [comments, setComments] = useState<CommentModel[]>([])
    const [isLoading, setIsLoading] = useState<boolean>(false)
    const [errorMessage, setErrorMessage] = useState<string | null>(null);
    const [lastFetchedAt, setLastFetchedAt] = useState<number | null>(Date.now())

    const fetch = async () => {
        if (!postId) {
            setErrorMessage('post id is not given')
            return
        }
        setIsLoading(true)
        try {
            await axios.get(ApiRoute.getParentComments.url, {
                params: {
                    postId,
                    page,
                    pageSize
                }
            }).then(res => res.data.comments as CommentModel[]).then(data => setComments(data))
        } catch (err) {
            console.error(err)
            setComments([])
            setErrorMessage('댓글을 가져오는데 실패하였습니다')
        } finally {
            setIsLoading(false)
        }
    }

    const refetch = () => setLastFetchedAt(Date.now())

    const submit = async (content: string) => {
        setIsLoading(true)
        try {
            await axios({
                ...ApiRoute.createParentComment,
                data: {
                    content,
                    postId
                }
            })
            refetch()
        } catch (err) {
            console.error(err)
            setErrorMessage('댓글 등록에 실패하였습니다')
        } finally {
            setIsLoading(false)
        }
    }

    useEffect(() => {
        fetch()
    }, [postId, page, pageSize, lastFetchedAt])

    return { comments, isLoading, errorMessage, refetch, submit }
}

export function useChildComments({ parentId, page, pageSize }: ChildCommentProps) {
    const [comments, setComments] = useState<CommentModel[]>([])
    const [isLoading, setIsLoading] = useState<boolean>(false)
    const [errorMessage, setErrorMessage] = useState<string | null>(null);
    const [lastFetchedAt, setLastFetchedAt] = useState<number | null>(Date.now())

    const fetch = async () => {
        if (!parentId) {
            setErrorMessage('parent id is not given')
            return
        }
        setIsLoading(true)
        try {
            await axios.get(ApiRoute.getChildComments.url, {
                params: {
                    parentId,
                    page,
                    pageSize
                }
            }).then(res => res.data.comments as CommentModel[]).then(data => setComments(data))
        } catch (err) {
            console.error(err)
            setComments([])
            setErrorMessage('댓글을 가져오는데 실패하였습니다')
        } finally {
            setIsLoading(false)
        }
    }

    const refetch = () => setLastFetchedAt(Date.now())

    const submit = async (content: string) => {
        setIsLoading(true)
        try {
            await axios({
                ...ApiRoute.createChildComment,
                data: {
                    content,
                    parentId
                }
            })
        } catch (err) {
            console.error(err)
            setErrorMessage('댓글 등록에 실패하였습니다')
        } finally {
            setIsLoading(false)
        }
    }

    useEffect(() => {
        fetch()
    }, [parentId, page, pageSize, lastFetchedAt])

    return { comments, isLoading, errorMessage, refetch, submit }
}