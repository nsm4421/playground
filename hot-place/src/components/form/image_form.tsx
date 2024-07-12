import { faImage } from "@fortawesome/free-solid-svg-icons"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { Dispatch, SetStateAction } from "react"
import Image from "next/image"

interface ImageFormProps {
    inputId: string;
    maxCount: number,
    images: File[],
    setImages: Dispatch<SetStateAction<File[]>>
}

export default function ImageForm({
    inputId,
    maxCount,
    images,
    setImages
}: ImageFormProps) {

    const handleOnSelect = async (event: React.ChangeEvent<HTMLInputElement>): Promise<void> => {
        const selected = event.target.files;
        if (!selected || selected.length === 0) return
        setImages(Array.from(selected))
    }

    const handleClickImageButton = () => {
        document.getElementById(inputId)?.click()
    }

    return <div>
        <div className="flex justify-between">
            <div>
                <h3 className="text-xl font-semibold bg-slate-700 rounded-lg px-2 py-1 text-white inline">Images</h3>
                <span className="ml-5 text-gray-500">{`최대 ${maxCount}개의 이미지를 업로드할 수 있습니다`}</span>
            </div>

            {/* 업로드 버튼 */}
            <button className="hover:bg-orange-300 p-1 rounded-md cursor"
                onClick={handleClickImageButton}>
                <FontAwesomeIcon icon={faImage} />
                <label className="ml-3">이미지 선택하기</label>
                <input id={inputId} className="hidden" accept="image/*" type="file" multiple={true} onChange={handleOnSelect} />
            </button>
        </div>

        {/* 선택한 이미지 */}
        <ul className="flex justify-start mt-3 mx-3">
            {
                images && images.map((image, index) => <li key={index} className="mr-4 h-auto">
                    <Image src={URL.createObjectURL(image)} alt={`${index}th-image`} width={100} height={100} />
                </li>)
            }
        </ul>
    </div>
}