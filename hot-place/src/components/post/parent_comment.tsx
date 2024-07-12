
import { useParentComment } from "@/util/hook/useComment";
import { Dispatch, SetStateAction, useState } from "react";
import Textarea from "../form/textarea";
import CommentItem from "./comment_item";

interface CommentPageProps {
    currentPostId: string | null
    setCurrentPostId: Dispatch<SetStateAction<string | null>>
}


export default function ParentComment({
    currentPostId,
    setCurrentPostId
}: CommentPageProps) {
    const MAX_COMMENT_LENGTH = 300;

    const [content, setContent] = useState<string>('')
    const [page, setPage] = useState<number>(1)
    const { comments, isLoading, submit } = useParentComment({ postId: currentPostId || "", page, pageSize: 10 })

    const handleSubmit = async () => {
        if (content === "") {
            return
        }
        try {
            await submit(content)
            setContent("")
        } catch (err) {
            console.error(err)
        }
    }
    const handleClose = () => setCurrentPostId(null)

    return <div>
        {
            currentPostId && <section className="fixed inset-0 flex items-center justify-center z-50">
                <div className="fixed inset-0 bg-gray-500 opacity-75" onClick={handleClose}></div>
                <div className="bg-white p-8 rounded-lg z-50 w-4/5">
                    <div>
                        <div className="flex justify-between items-start">
                            <div className="w-full">
                                <Textarea content={content} setContent={setContent}
                                    placeholder={`댓글을 입력해주세요(최대${MAX_COMMENT_LENGTH}자)`}
                                    maxRow={3} maxLength={MAX_COMMENT_LENGTH} hideErrorMessage={true} hideCountText={true} />
                            </div>
                            <button onClick={handleSubmit} className="mt-3 min-w-fit ml-3 text-xl font-bold rounded-md bg-sky-600 hover:bg-sky-500 text-white px-2 py-1" disabled={isLoading}>제출하기</button>
                        </div>
                        <ul>
                            {
                                comments.map((comment) => <li>
                                    <CommentItem comment={comment} />
                                </li>)
                            }
                        </ul>
                    </div>
                </div>
            </section>
        }
    </div>
}
