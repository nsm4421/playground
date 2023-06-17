'use client'
import Button from '@/components/button-component'
import ImageUploadButton from '@/components/image-upload-button'
import StartRating from '@/components/rating-star-component'

import TextArea from '@/components/text-area-component'
import { SetStateAction, useState } from 'react'

export default function ReviewForm() {
  const [content, setContent] = useState<string>('')
  const [images, setImages] = useState<string[]>([])
  const [rating, setRating] = useState<number>(5)
  const MAX_CHARACTER = 300
  return (
    <div>
      <div className="flex justify-center">
        <StartRating
          size="LG"
          min={1}
          max={5}
          rating={rating}
          setRating={setRating}
        />
      </div>

      <div className="mt-10">
        <TextArea
          content={content}
          setContent={setContent}
          rows={5}
          maxCharactor={MAX_CHARACTER}
          placeholder="리뷰를 작성해주세요(최대 300자)"
        />
        <p className="text-right text-gray-500 dark:text-gray-400">
          ({content.length}/{MAX_CHARACTER})
        </p>
      </div>

      <div className="mt-5 flex justify-between align-middle">
        <ImageUploadButton maxNum={3} images={images} setImages={setImages} />
        <Button label={'제출하기'} onClick={() => {}} />
      </div>
    </div>
  )
}
