import PostModel from "@/data/model/post_model"
import { faComment, faEllipsis, faEllipsisVertical, faHashtag, faHeart, faMessage, faXmark } from "@fortawesome/free-solid-svg-icons"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import Carousel from "./carousel"

interface PostItemProps {
    post: PostModel
}

export default function PostItem({ post }: PostItemProps) {

    // TODO : 더보기 버튼 클릭 시 이벤트
    const handleMoreButton = async () => { }
    const handleLikeButton = async () => { }
    const handleCommentButton = async () => { }
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

        {/* TODO : 좋아요, 댓글, DM 버튼 */}
        <div>
            <ul className="mt-3 flex-wrap flex">
                <li className="mr-6 items-center">
                    <button onClick={handleLikeButton} className="flex items-center">
                        <i className="hover:text-rose-600 flex justify-center items-center text-center rounded-full w-5 h-5 opacity-25 hover:opacity-100">
                            <FontAwesomeIcon icon={faHeart} className="text-sm" />
                        </i>
                        <span className="ml-2">좋아요 개수</span>
                    </button>
                </li>
                <li className="mr-6">
                    <button onClick={handleCommentButton} className="flex items-center">
                        <i className="hover:text-sky-600 flex justify-center items-center text-center rounded-full w-5 h-5 opacity-25 hover:opacity-100">
                            <FontAwesomeIcon icon={faComment} className="text-sm" />
                        </i>
                        <span className="ml-2">댓글</span>
                    </button>
                </li>
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