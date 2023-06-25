'use client'
import Button from '@/components/atom/button-component'
import ImageUploadButtons from '@/components/atom/image-upload-button'
import StartRating from '@/components/atom/rating-star-component'

import TextArea from '@/components/atom/text-area-component'
import { useState } from 'react'
import axios from 'axios'
import Input from '@/components/atom/input-component'
import { useRouter } from 'next/navigation'

const MAX_CHARACTER_MENU = 30
const MAX_CHARACTER_CONTENT = 300

interface Props {
  restaurantId: string
}

export default function ReviewForm(props: Props) {
  const router = useRouter()
  const [content, setContent] = useState<string>('')
  const [images, setImages] = useState<string[]>([])
  const [rating, setRating] = useState<number>(5)
  const [menu, setMenu] = useState<string>('')
  const [menuCharacterVisible, setMenuCharacterVisible] =
    useState<boolean>(false)
  const [contentCharacterVisible, setContentCharacterVisible] =
    useState<boolean>(false)

  const handleSubmit = async () => {
    await axios
      .post('/api/review', {
        ...props,
        content,
        menu,
        rating,
      })
      .then(() => {
        router.refresh()
      })
      .catch(console.error)
  }
  return (
    <>
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
        <Input
          onFocus={() => setMenuCharacterVisible(true)}
          onPointerLeave={() => setMenuCharacterVisible(false)}
          content={menu}
          setContent={setMenu}
          maxCharactor={MAX_CHARACTER_MENU}
          placeholder="메뉴를 입력해주세요(최대 30자)"
        />
        {menuCharacterVisible && (
          <span className="float-right text-sm mt-1 text-gray-500 dark:text-gray-400">
            ({menu.length}/{MAX_CHARACTER_MENU})
          </span>
        )}
      </div>

      <div className="mt-10">
        <TextArea
          onFocus={() => setContentCharacterVisible(true)}
          onPointerLeave={() => setContentCharacterVisible(false)}
          content={content}
          setContent={setContent}
          rows={5}
          maxCharactor={MAX_CHARACTER_CONTENT}
          placeholder="리뷰를 작성해주세요(최대 300자)"
        />
        {contentCharacterVisible && (
          <span className="float-right text-sm mt-1 text-gray-500 dark:text-gray-400">
            ({content.length}/{MAX_CHARACTER_CONTENT})
          </span>
        )}
      </div>

      <div className="mt-10 mb-3 flex justify-between align-middle">
        <ImageUploadButtons maxNum={3} images={images} setImages={setImages} />
        <Button label={'제출하기'} onClick={handleSubmit} />
      </div>
    </>
  )
}
