import axios from "axios";
import { useCallback, useEffect, useState } from "react";
import ApiRoute from "../constant/api_route";
import PostModel from "@/data/model/post_model";

interface UsePostsProps {
    page: number;
    pageSize: number;
}

export default function usePosts({ page, pageSize }: UsePostsProps) {
    const [posts, setPosts] = useState<PostModel[]>([])
    const [isLoading, setIsLoading] = useState<boolean>(false)
    const [errorMessage, setErrorMessage] = useState<string | null>(null);

    const fetchPosts = useCallback(async () => {
        setIsLoading(true)
        try {
            await axios.get(ApiRoute.getPosts.url, {
                params: {
                    page,
                    pageSize
                }
            }).then(res => res.data.posts).then(data => setPosts(data))
        } catch (err) {
            console.error(err)
            setPosts([])
            setErrorMessage('fail to fetch post')
        } finally {
            setIsLoading(false)
        }
    }, [page, pageSize])

    useEffect(() => {
        fetchPosts()
    }, [fetchPosts])

    return { posts, isLoading, errorMessage }
}