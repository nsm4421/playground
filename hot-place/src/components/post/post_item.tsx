import PostModel from "@/data/model/post_model"
import { faComment, faEllipsisVertical, faHashtag, faMessage } from "@fortawesome/free-solid-svg-icons"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import LikeIcon from "./like_icon";
import { Dispatch, SetStateAction } from "react";

interface PostItemProps {
    post: PostModel,
    setCurrentPostId: Dispatch<SetStateAction<string | null>>
}

export default function PostItem({ post, setCurrentPostId }: PostItemProps) {

    // TODO
    const handleMoreButton = async () => { }
    const handleCommentButton = () => setCurrentPostId(post.id)
    const handleDirectMessageButton = async () => { }

    return <li className="rounded-lg bg-slate-200 px-2 py-1 mt-4 mx-1">
        {/* 유저 프로필 */}
        <div className="text-xl font-semibold text-slate-600 flex justify-between">
            <div className="inline">
                <label> @TODO : 유저명, 프로필 사진 가져오기 </label>
            </div>
            <button onClick={handleMoreButton}>
                <i className="hover:text-sky-600 hover:bg-sky-200 flex justify-center items-center text-center rounded-full w-5 h-5">
                    <FontAwesomeIcon icon={faEllipsisVertical} className="text-sm" />
                </i>
            </button>
        </div>

        {/* 본문 */}
        <div className="text-xl font-semibold text-slate-600 flex justify-between">
            <div className="inline">
                <span>{post.content}</span>
            </div>
        </div>

        {/* 해시태그 */}
        <div className="mt-3">
            <ul className="mt-3 flex-wrap flex">
                {
                    post.hashtags.map((hashtag, index) => <li className="text-xl font-bold inline mt-2 mr-3 p-1 rounded-md text-sky-600 border-sky-300 border-2" key={index}>
                        <FontAwesomeIcon icon={faHashtag} className="text-sm mr-2" />
                        <label className="mr-2">{hashtag}</label>
                    </li>)
                }
            </ul>
        </div>

        <div>
            <ul className="mt-3 flex-wrap flex">
                {/* 좋아요 아이콘 */}
                <li className="mr-6 items-center">
                    <LikeIcon postId={post.id} />
                </li>
                {/* 댓글 버튼 */}
                <li className="mr-6">
                    <button onClick={handleCommentButton} className="flex items-center">
                        <i className="hover:text-sky-600 flex justify-center items-center text-center rounded-full w-5 h-5 opacity-25 hover:opacity-100">
                            <FontAwesomeIcon icon={faComment} className="text-sm" />
                        </i>
                        <span className="ml-2">댓글</span>
                    </button>
                </li>
                {/* DM버튼 */}
                <li>
                    <button onClick={handleDirectMessageButton} className="flex items-center">
                        <i className="hover:text-green-600 flex justify-center items-center text-center rounded-full w-5 h-5 opacity-25 hover:opacity-100">
                            <FontAwesomeIcon icon={faMessage} className="text-sm" />
                        </i>
                        <span className="ml-2">DM</span>
                    </button>
                </li>
            </ul>
        </div>
    </li>
}