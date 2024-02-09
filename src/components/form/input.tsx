import { ChangeEvent, Dispatch, SetStateAction, useState } from "react";

interface InputProps {
    label:string;
    content: string;
    setContent: Dispatch<SetStateAction<string>>
    maxLength: number;
    placeholder: string;
}

export default function Input({
    label, content, setContent, maxLength, placeholder
}: InputProps) {

    const [errorMessage, setErrorMessage] = useState<string>('')

    const handleContent = (e: ChangeEvent<HTMLInputElement>) => {
        const text = e.target.value
        if (text.length <= maxLength) {
            setContent(text)
            setErrorMessage('')
        } else {
            setErrorMessage(`최대 ${maxLength}까지 입력 가능합니다`)
        }
    }

    return <div className="mt-3">
        <h3 className="text-xl font-semibold bg-slate-700 rounded-lg px-2 py-1 text-white inline">{label}</h3>
        <input className="mt-3 tracking-wider text-lg w-full max-h-10em resize-none border rounded-md focus:outline-none focus:ring focus:border-blue-100 p-2"
            onChange={handleContent}
            value={content}
            placeholder={placeholder} />
        <div className="flex justify-between">
            <span className="text-rose-700">{errorMessage}</span>
            <span className="text-slate-700">{content.length}/{maxLength}</span>
        </div>
    </div>
}