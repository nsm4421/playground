'use client'
import { Dispatch, SetStateAction } from 'react'
import { AiOutlineCamera } from 'react-icons/ai'

interface Props {
  maxNum: number
  images: string[]
  setImages: Dispatch<SetStateAction<string[]>>
}

// TODO : Image upload
export default function ImageUploadButton(props: Props) {
  return (
    <div className="flex">
      {Array.from({ length: props.maxNum }, (_, idx) => idx).map((idx) => (
        <AiOutlineCamera
          key={idx}
          className="border text-4xl p-1 mr-2 text-slate-500 dark:text-slate-200"
        />
      ))}
    </div>
  )
}
