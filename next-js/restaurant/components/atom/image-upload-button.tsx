'use client'
import Image from 'next/image'
import { Dispatch, SetStateAction, useEffect, useRef } from 'react'
import { AiOutlineCamera } from 'react-icons/ai'
import { IoIosRefresh } from 'react-icons/io'

interface Props {
  maxNum: number
  images: string[]
  setImages: Dispatch<SetStateAction<string[]>>
}

const emptyStringArr = (length: number) => Array.from({ length }, (_, __) => '')

export default function ImageUploadButtons(props: Props) {
  const handleRefresh = () => {
    props.images.map((image) => {
      if (image) URL.revokeObjectURL(image)
    })
    props.setImages(emptyStringArr(props.maxNum))
  }

  useEffect(() => {
    props.setImages(emptyStringArr(props.maxNum))
  }, [])
  return (
    <div className="flex align-middle">
      {Array.from({ length: props.maxNum }, (_, idx) => idx).map((idx) => (
        <ImageUploadButton {...props} idx={idx} key={idx} />
      ))}
      <IoIosRefresh
        className="ml-5 text-3xl p-1 hover:text-orange-600"
        onClick={handleRefresh}
      />
    </div>
  )
}

function ImageUploadButton(props: Props & { idx: number }) {
  const inputRef = useRef<HTMLInputElement>(null)
  const onClick = () => {
    if (!inputRef) {
      return
    }
    inputRef.current?.click()
  }
  const handlePick =
    (idx: number) => (e: React.ChangeEvent<{ files: FileList | null }>) => {
      if (e.target.files && e.target.files.length > 0) {
        const file = e.target.files[0]
        const newImages = [...props.images]
        newImages[idx] = URL.createObjectURL(file)
        props.setImages(newImages)
      }
    }
  return (
    <>
      {!props.images[props.idx] && (
        <input
          ref={inputRef}
          type="file"
          className="hidden"
          onChange={handlePick(props.idx)}
        />
      )}

      {props.images[props.idx] ? (
        // file selected
        <Image
          className="border text-4xl p-1 mr-2 text-slate-500 dark:text-slate-200"
          src={props.images[props.idx]}
          alt={`${props.idx + 1}th-img`}
          width={50}
          height={50}
        />
      ) : (
        // file not selected
        <AiOutlineCamera
          onClick={onClick}
          className="border text-4xl p-1 mr-2 text-slate-500 dark:text-slate-200"
        />
      )}
    </>
  )
}
