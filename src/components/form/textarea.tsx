import { ChangeEvent, Dispatch, SetStateAction, useCallback, useEffect, useState } from "react";

interface TextareaProps {
    label?: string;
    initRow?: number;
    maxRow?: number;
    maxLength: number;
    content: string;
    setContent: Dispatch<SetStateAction<string>>
    placeholder?: string
    hideErrorMessage?: boolean,
    hideCountText?: boolean
}

const DEFAULT_INIT_ROW = 1
const DEFAULT_MAX_ROW = 5

export default function Textarea({ label, initRow, maxRow, maxLength, content, setContent, placeholder, hideErrorMessage, hideCountText }: TextareaProps) {

    const [errorMessage, setErrorMessage] = useState<String>('')
    const [currentRow, setCurrentRow] = useState<number>(initRow ?? DEFAULT_INIT_ROW)

    const handleContent = useCallback((e: ChangeEvent<HTMLTextAreaElement>) => {
        const text = e.target.value
        if (text.length <= maxLength) {
            setContent(text)
            setErrorMessage('')
        } else {
            setErrorMessage(`최대 ${maxLength}까지 입력 가능합니다`)
        }
    }, [setContent])

    useEffect(() => {
        setCurrentRow(Math.min(content.split('\n').length, maxRow ?? DEFAULT_MAX_ROW))
    }, [content])

    return <div>
        {/* 라벨 */}
        {
            label && <h3 className="text-xl font-semibold bg-slate-700 rounded-lg px-2 py-1 text-white inline">{label}</h3>
        }

        {/* 텍스트 입력 */}
        <textarea className="mt-3 tracking-wider text-lg w-full max-h-10em resize-none border rounded-md focus:outline-none focus:ring focus:border-blue-100 p-2"
            rows={currentRow}
            onChange={handleContent}
            value={content}
            placeholder={placeholder ?? "본문을 입력해주세요"} />

        <div className="flex justify-between">
            {/* 에러 메세지 */}
            <span className="text-rose-700">
                {
                    !hideErrorMessage && content === ""
                        ? "본문을 입력해주세요"
                        : errorMessage
                }</span>
            {/* 글자수 카운팅 */}
            {
                !hideCountText &&
                <span className="text-slate-700">{content.length}/{maxLength}</span>
            }
        </div>
    </div>
}