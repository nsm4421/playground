import Hashtags from "@/components/form/hashtags";
import ImageForm from "@/components/form/image_form";
import Input from "@/components/form/input";
import Textarea from "@/components/form/textarea";
import AddressPicker from "@/components/map/AddressPicker";
import { RoadAdress } from "@/data/model/location_model";
import ApiRoute from "@/util/constant/api_route";
import UseFile from "@/util/hook/useFile";
import { faLocation } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import axios from "axios";
import { useRouter } from "next/router";
import { useState } from "react";

const MAX_NAME_LENGTH = 30
const MAX_CONTENT_LENGTH = 300
const MAX_HASHTAG_LENGTH = 20
const MAX_HASHTAG_COUNT = 3
const MAX_IMAGE_COUNT = 3
const INPUT_ID = 'input_id'

export default function CreatePlacePage() {

    const router = useRouter()

    const [name, setName] = useState<string>('')
    const [address, setAddress] = useState<RoadAdress | null>(null)
    const [isLoding, setIsLoading] = useState<boolean>(false)
    const [content, setContent] = useState<string>('')
    const [hashtags, setHashtags] = useState<string[]>([])
    const { files: imageFiles, setFiles: setImageFiles, urls: images, upload: uplloadImages } = UseFile({
        bucket: "images",
        pathPrefix: "place"
    })

    const handleUpload = async () => {
        setIsLoading(true)
        try {
            // 필드값 검사
            if (name.trim() === '' || content.trim() === "") {
                alert('장소명이나 본문을 확인해주세요')
                return
            }

            if (!address){
                alert('장소를 입력해주세요')
                return 
            }

            // 이미지 업로드
            await uplloadImages()

            // 데이터 자장
            await axios({
                ...ApiRoute.createPlace, data: {
                    content, hashtags, images, name, address
                }
            })

            // 성공 시, 루트 페이지로 이동
            router.push("/")
            alert("핫플 등록에 성공하였습니다")
        } catch (err) {
            console.error(err)
            alert("업로드 중 에러가 발생했습니다")
        } finally {
            setIsLoading(false)
        }
    }

    return <div className="px-2 py-1">
        <div className="justify-between flex items-center mx-2 mt-3">
            <div className="flex items-center">
                <FontAwesomeIcon icon={faLocation} />
                <h1 className="text-4xl font-bold ml-3">핫플 등록하기</h1>
            </div>

            <button className="bg-green-700 hover:bg-green-600 text-white text-2xl px-2 py-1 rounded-lg" disabled={isLoding} onClick={handleUpload}>업로드</button>

        </div>

        <section>

            {/* TODO : 지도 */}
            <div className="mt-5">
                <AddressPicker label={"Address"} address={address} setAddress={setAddress} />
            </div>

            {/* 이름 */}
            <div className="mt-5">
                <Input label={"Name"} content={name} setContent={setName} maxLength={MAX_NAME_LENGTH} placeholder={"장소명을 입력해주세요"} />
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
            <div className="mt-5">
                <ImageForm inputId={INPUT_ID} maxCount={MAX_IMAGE_COUNT} images={imageFiles} setImages={setImageFiles} />
            </div>

        </section>
    </div>
}