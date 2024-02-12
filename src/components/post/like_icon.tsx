import ApiRoute from "@/util/constant/api_route"
import { faHeart } from "@fortawesome/free-solid-svg-icons"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import axios from "axios"
import { useEffect, useState } from "react"

interface LikeIconProps {
    postId: string
}

export default function LikeIcon({ postId }: LikeIconProps) {
    const [isLike, setIsLike] = useState<boolean>(false)
    const [isLoading, setIsLoading] = useState<boolean>(false)
    const [likeCount, setLikeCount] = useState<number>(0)

    // 좋아요 개수 가져오기
    const getLikeCount = async () => {
        setIsLoading(true)
        try {
            await axios({
                ...ApiRoute.getLikeCount,
                params: {
                    postId
                }
            }).then(res => res.data)
                .then(data => {
                    setIsLike(data.isLike)
                    setLikeCount(data.count)
                })
        } catch (err) {
            console.error(err)
        } finally {
            setIsLoading(false)
        }
    }

    /// 좋아요 버튼 클릭 이벤트
    const handleLikeButton = async () => {
        setIsLoading(true)
        try {
            // 좋아요, 좋아요 취소 요청
            if (isLike) {
                await axios({ ...ApiRoute.cancelLike, params: { postId } })
            } else {
                await axios({ ...ApiRoute.likePost, data: { postId } })
            }
            // 좋아요 개수 다시 가져오기
            await getLikeCount()
        } catch (err) {
            console.error(err)
        } finally {
            setIsLoading(false)
        }
    }

    useEffect(() => {
        getLikeCount()
    }, [setIsLike])

    return <button onClick={handleLikeButton} disabled={isLoading} className={`flex items-center ${isLoading ? "cursor-wait" : "cursor-pointer"}`}>
        <i className={`${isLike ? "text-rose-600 hover:text-slate-600 hover:opacity-100" : "text-slate-600 hover:text-rose-600 hover:opacity-100"} flex justify-center items-center text-center rounded-full w-5 h-5 opacity-25`}>
            <FontAwesomeIcon icon={faHeart} className="text-sm" />
        </i>
        <span className="ml-2">{likeCount}</span>
    </button>
}