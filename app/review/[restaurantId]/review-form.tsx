'use client'
import Button from '@/components/atom/button-component'
import ImageUploadButtons from '@/components/atom/image-upload-button'
import StartRating from '@/components/atom/rating-star-component'

import TextArea from '@/components/atom/text-area-component'
import { useState } from 'react'
import axios from 'axios'
import Input from '@/components/atom/input-component'
import uploadImageAndReturnFilename from '@/util/db/s3/s3-upload-file'
import { useRecoilState } from 'recoil'
import lastFetchedAt from './review-state'

const MAX_CHARACTER_MENU = 30 // 메뉴 input 글자 최대길이
const MAX_CHARACTER_CONTENT = 300 // 리뷰 input 글자 최대길이

export default function ReviewForm(props: { restaurantId: string }) {
  const [content, setContent] = useState<string>('')
  const [images, setImages] = useState<string[]>([])
  const [rating, setRating] = useState<number>(5)
  const [menu, setMenu] = useState<string>('')
  const [menuCharacterVisible, setMenuCharacterVisible] =
    useState<boolean>(false)
  const [contentCharacterVisible, setContentCharacterVisible] =
    useState<boolean>(false)
  const [_, setLastFetched] = useRecoilState(lastFetchedAt)
  // 리뷰 저장
  const handleSubmit = async () => {
    let imageUrls: string[] = []
    // Bucket에 이미지 업로드 후 업로드한 이미지 경로 list로 반환
    for (const image of images) {
      const url = await uploadImageAndReturnFilename(image)
      if (url) imageUrls.push(url)
    }
    // DB에 저장
    await axios
      .post('/api/review', {
        ...props,
        content,
        menu,
        rating,
        ...(imageUrls.length > 0 && { images: imageUrls.toString() }),
      })
      .then(() => {
        setLastFetched(Date.now())
        setMenu('')
        setContent('')
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
        <Button label={'리뷰등록'} onClick={handleSubmit} />
      </div>
    </>
  )
}
