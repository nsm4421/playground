import ApiRoute from "@/util/constant/api_route";
import axios from "axios";
import { useRouter } from "next/router";
import { useState } from "react"
import Hashtags from "@/components/form/hashtags";
import Textarea from "@/components/form/textarea";
import ImageForm from "@/components/form/image_form";
import UseFile from "@/util/hook/useFile";

const MAX_CONTENT_LENGTH = 1000         // 본문 글자수 제한
const MAX_HASHTAG_LENGTH = 15           // 해시태그 글자수 제한
const MAX_HASHTAG_COUNT = 5             // 해시태그 개수 제한
const MAX_IMAGE_NUM = 3               // 이미지 개수 제한
const INPUT_ID = 'image'

export default function CreatePostPage() {

    const [isLoading, setIsLoading] = useState<boolean>(false)
    const [content, setContent] = useState<string>('')
    const [hashtags, setHashtags] = useState<string[]>([])
    const { files: imageFiles, setFiles: setImageFiles, upload: uploadImages, urls: images } = UseFile({
        bucket: 'images',
        pathPrefix: 'post'
    })

    const router = useRouter()

    /// 포스트 업로드
    const handleUpload = async () => {
        setIsLoading(true)
        try {
            // 필드 검사
            if (content.trim() === "") {
                alert('본문을 입력해주세요')
                return
            }

            // 이미지 업로드
            await uploadImages()

            // DB에 데이터 업로드
            await axios({
                ...ApiRoute.createPost,
                data: {
                    content,
                    hashtags,
                    images
                }
            })

            // 성공 시 포스팅 페이지로
            router.push("/post")
            window.alert("포스팅 업로드에 성공하였습니다")
        } catch {
            window.alert('포스트 업로드 중 에러가 발생했습니다')
        } finally {
            setIsLoading(false)
        }
    }

    return <div className="h-full w-full">
        <div className="p-3 mt-3 flex justify-between px-3">
            <h1 className="text-4xl font-extrabold inline">포스팅 업로드</h1>

            {/* 업로드 버튼 */}
            <button className={isLoading ? "bg-slate-400 text-slate-200 text-xl rounded-md p-2" : "bg-green-700 text-white text-xl rounded-md p-2"}
                onClick={handleUpload} disabled={isLoading}>
                {isLoading ? "로딩중..." : "업로드"}
            </button>
        </div>

        <section className="px-3">

            {/* 본문 */}
            <div className="mt-3">
                <Textarea label={'Content'} maxLength={MAX_CONTENT_LENGTH} content={content} setContent={setContent} />
            </div>

            {/* 해시태그 */}
            <div className="mt-5">
                <Hashtags maxCount={MAX_HASHTAG_COUNT} maxLength={MAX_HASHTAG_LENGTH} hashtags={hashtags}
                    setHashtags={setHashtags} />
            </div>

            {/* 이미지 */}
            <div className="mt-8">
                <ImageForm inputId={INPUT_ID} maxCount={MAX_IMAGE_NUM} images={imageFiles} setImages={setImageFiles} />
            </div>
        </section>
    </div>
}