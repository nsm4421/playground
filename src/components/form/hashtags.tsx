import { faHashtag, faXmark } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { ChangeEvent, Dispatch, SetStateAction, useState } from "react"

interface HashtagsProps {
    maxLength: number;
    maxCount: number;
    hashtags: string[];
    setHashtags: Dispatch<SetStateAction<string[]>>
}

export default function Hashtags({
    maxLength,
    maxCount,
    hashtags,
    setHashtags
}: HashtagsProps) {

    const [currentHashtag, setCurrentHashtag] = useState<string>("")
    const [errorMessage, setErrorMessage] = useState<string>("")

    const handleCurrentHashtag = (e: ChangeEvent<HTMLInputElement>) => {
        const text = e.target.value
        if (text.includes("#")) {
            setCurrentHashtag("#를 사용할 수 없습니다")
        } else if (text.length > maxLength) {
            setCurrentHashtag(`최대 ${maxLength}자 내외로 입력해주세요`)
        } else {
            setCurrentHashtag(text)
        }
    }

    const handleKeyUp = (e: any) => {
        if (e.key !== "Enter") return
        const newHashtag = e.target.value.trim()
        if (hashtags.length >= maxCount) {
            setErrorMessage(`최대 ${maxCount}개까지 입력가능합니다`)
        } else if (hashtags.includes(newHashtag)) {
            setErrorMessage(`${newHashtag}는 중복된 해시태그입니다`)
        } else if (e.keyCode === 32) {
            setErrorMessage("해시태그에 띄어쓰기를 사용할 수 없습니다")
        } else if (newHashtag !== "") {
            setHashtags([...hashtags, newHashtag])
            setCurrentHashtag("")
            setErrorMessage("")
        }
    }

    const handleDeleteHashtag = (index: number) => () => {
        const newHashtags = [...hashtags]
        if (index < 0 || index >= newHashtags.length) {
            console.error("해시태그 삭제 기능 시 부적절한 index가 들어옴")
            return
        }
        newHashtags.splice(index, 1)
        setHashtags(newHashtags)
    }

    return <div>
        <div className="grid grid-cols-[auto,1fr] gap-4 items-start">
            <h3 className="text-xl h-fit font-semibold bg-slate-700 rounded-lg px-2 py-1 text-white inline">Hashtag</h3>
            <div>
                <input className="w-full tracking-wider text-lg border rounded-md focus:outline-none focus:ring focus:border-blue-100 p-2"
                    placeholder={`해시태그를 입력하고 엔터를 눌러주세요(최대 ${maxCount}개)`}
                    value={currentHashtag} onChange={handleCurrentHashtag}
                    onKeyUp={handleKeyUp} />
                <div className="flex justify-between">
                    <span className="text-rose-700">{errorMessage}</span>
                    <span className="text-slate-700">{currentHashtag.length}/{maxLength}</span>
                </div>
            </div>

        </div>
        <ul className="mt-2 flex-wrap flex">
            {
                hashtags.map((hashtag, index) => <li className="text-xl font-bold inline mt-2 mr-3 p-1 rounded-md text-sky-600 border-sky-300 border-2" key={index}>
                    <FontAwesomeIcon icon={faHashtag} className="text-sm mr-2" />
                    <label className="mr-2">{hashtag}</label>
                    <FontAwesomeIcon icon={faXmark} className="text-sm cursor-pointer" onClick={handleDeleteHashtag(index)} />
                </li>)
            }
        </ul>
    </div>
}