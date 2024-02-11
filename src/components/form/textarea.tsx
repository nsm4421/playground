import { ChangeEvent, Dispatch, SetStateAction, useCallback, useEffect, useState } from "react";

interface TextareaProps {
    label: string;
    maxLength: number;
    content: string;
    setContent: Dispatch<SetStateAction<string>>
    placeholder?: string
}


export default function Textarea({ label, maxLength, content, setContent, placeholder }: TextareaProps) {

    const [errorMessage, setErrorMessage] = useState<String>('')

    const handleContent = useCallback((e: ChangeEvent<HTMLTextAreaElement>) => {
        const text = e.target.value
        if (text.length <= maxLength) {
            setContent(text)
            setErrorMessage('')
        } else {
            setErrorMessage(`최대 ${maxLength}까지 입력 가능합니다`)
        }
    }, [setContent])

    return <div>
        {
            label && <h3 className="text-xl font-semibold bg-slate-700 rounded-lg px-2 py-1 text-white inline">{label}</h3>
        }

        <textarea className="mt-3 tracking-wider text-lg w-full max-h-10em resize-none border rounded-md focus:outline-none focus:ring focus:border-blue-100 p-2"
            rows={5}
            onChange={handleContent}
            value={content}
            placeholder={placeholder ?? "본문을 입력해주세요"} />
        <div className="flex justify-between">
            <span className="text-rose-700">
                {
                    content === ""
                        ? "본문을 입력해주세요"
                        : errorMessage
                }</span>
            <span className="text-slate-700">{content.length}/{maxLength}</span>
        </div>
    </div>
}