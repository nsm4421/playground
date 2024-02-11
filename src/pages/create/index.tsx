import Hashtags from "@/components/form/hashtags";
import ImageForm from "@/components/form/image_form";
import Input from "@/components/form/input";
import Textarea from "@/components/form/textarea";
import { faLocation } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import axios from "axios";
import { SetStateAction, useState } from "react";

const MAX_NAME_LENGTH = 30
const MAX_CONTENT_LENGTH = 300
const MAX_HASHTAG_LENGTH = 20
const MAX_HASHTAG_COUNT = 3
const MAX_IMAGE_COUNT = 3
const INPUT_ID = 'input_id'

export default function CreatePlacePage() {

    const [name, setName] = useState<string>('')
    const [isLoding, setIsLoading] = useState<boolean>(false)
    const [content, setContent] = useState<string>('')
    const [hashtags, setHashtags] = useState<string[]>([])
    const [images, setImages] = useState<File[]>([])

    const handleUpload= async ()=>{
        try {
            setIsLoading(true)
        } catch {

        }finally{
            setIsLoading(false)
        }
    }

    return <div className="px-2 py-1">
        <div className="justify-between flex items-center mx-2 mt-3">
            <div className="flex items-center">
                <FontAwesomeIcon icon={faLocation} />
                <h1 className="text-4xl font-bold ml-3">핫플 등록하기</h1>
            </div>

            <button className="bg-green-700 hover:bg-green-600 text-white text-2xl px-2 py-1 rounded-lg" disabled={isLoding}>업로드</button>

        </div>

        <section>

            {/* 이름 */}
            <div className="mt-5">
                <Input label={"NAME"} content={name} setContent={setName} maxLength={MAX_NAME_LENGTH} placeholder={"장소명을 입력해주세요"} />
            </div>

            {/* 본문 */}
            <div className="mt-5">
                <Textarea label={"Content"} maxLength={MAX_CONTENT_LENGTH} content={content} setContent={setContent} />
            </div>

            {/* 해시태그 */}
            <div className="mt-5">
                <Hashtags maxLength={MAX_HASHTAG_LENGTH} maxCount={MAX_HASHTAG_COUNT} hashtags={hashtags} setHashtags={setHashtags} />
            </div>

            {/* 이미지 */}
            <div>
                <ImageForm inputId={INPUT_ID} maxCount={MAX_IMAGE_COUNT} images={images} setImages={setImages}/>
            </div>

        </section>
    </div>
}