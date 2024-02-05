import PostItem from "@/components/post/post_item";
import usePosts from "@/util/hook/usePost";
import { useState } from "react";

export default function PostPage() {

    const pageSize = 10
    const [page, setPage] = useState<number>(0);
    const { posts, isLoading, errorMessage } = usePosts({
        page, pageSize
    })

    // 로딩중
    if (isLoading) {
        return <div className="h-screen w-screen flex justify-center items-center">
            <h1 className="text-5xl text-center font-bold text-sky-800">로딩중입니다...</h1>
        </div>
    }

    // 에러
    if (errorMessage) {
        return <div className="h-screen w-screen flex justify-center items-center">
            <h1 className="text-5xl text-center font-bold text-rose-800">오류가 발생하였습니다 ㅠㅠ</h1>
            <h1 className="text-3xl text-center font-bold text-rose-600">{errorMessage}</h1>
        </div>
    }

    // 포스팅 리스트
    return <div className="h-full w-full p-3">
        <h1 className="text-4xl">포스팅</h1>
        <section className="mx-1 mt-5 p-3">
            <ul>
                {
                    posts.map((post, index) => <PostItem post={post} key={index} />)
                }
            </ul>
        </section>
    </div>
}