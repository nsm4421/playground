'use client'
import Button from '@/components/button-component'
import ImageUploadButtons from '@/components/image-upload-button'

import TextArea from '@/components/text-area-component'
import { useState } from 'react'
import Input from '@/components/input-component'
import { useRouter } from 'next/navigation'
import DropDownSlider from '@/components/dropdown-slider-component'
import axios from 'axios'
import categoriesItem from '@/util/model/category-items'
import S3 from '@/util/s3'
import { PutObjectCommand } from '@aws-sdk/client-s3'
import convertURLtoFile from '@/util/conver-url-to-file'

const MAX_CHARACTER_Name = 30
const MAX_CHARACTER_Description = 300

export default function RestaurantForm() {
  const router = useRouter()
  const [name, setName] = useState<string>('')
  const [selected, setSelected] = useState<number>(-1)
  const [description, setDiscription] = useState<string>('')
  const [images, setImages] = useState<string[]>([])
  const [nameCharacterVisible, setMenuCharacterVisible] =
    useState<boolean>(false)
  const [contentCharacterVisible, setContentCharacterVisible] =
    useState<boolean>(false)

  const uploadImageAndReturnFilename = async (url: string) => {
    try {
      const file = await convertURLtoFile(url)
      if (await !url) return null
      const filename = `${Math.random().toString(36).slice(2, 30)}`
      const res = await S3.send(
        new PutObjectCommand({
          Bucket: process.env.NEXT_PUBLIC_S3_BUCKET_NAME,
          Key: filename,
          Body: file,
          ContentType: file.type,
        })
      )
      if (res.$metadata.httpStatusCode?.toString() == '200') {
        return filename
      }
      return null
    } catch (err) {
      console.error(err)
    }
  }

  const handleSubmit = async () => {
    try {
      // concat image urls
      let imageUrls = ''
      for (const image of images) {
        if (image)
          imageUrls = `${imageUrls}|${
            process.env.NEXT_PUBLIC_S3_URL_PREFIX
          }__${await uploadImageAndReturnFilename(image)}`
      }
      console.table({
        name,
        category: selected === -1 ? null : categoriesItem[selected],
        description,
        ...(imageUrls !== '' && { images: imageUrls }),
      })
      // save restaurant
      await axios
        .post('/api/restaurant', {
          name,
          category: selected === -1 ? null : categoriesItem[selected],
          description,
          ...(imageUrls !== '' && { images: imageUrls }),
        })
        .then(() => router.push('/restaurant'))
        .catch(console.error)
    } catch (err) {
      console.error(err)
    }
  }

  return (
    <>
      <div className="mt-5">
        <div className="font-extrabold text-lg text-green-900 dark:text-slate-300 mb-1">
          카테고리
        </div>
        <div className="border border-green-900 dark:border-slate-500 rounded-lg m-1 p-1 max-w-fit">
          <DropDownSlider
            label={'카테고리'}
            items={categoriesItem}
            selected={selected}
            setSelected={setSelected}
          />
        </div>
      </div>

      <div className="mt-5">
        <div className="font-extrabold text-lg text-green-900 dark:text-slate-300 mb-1">
          가게명
        </div>
        <div className="m-1 p-1 max-w-full">
          <Input
            onFocus={() => setMenuCharacterVisible(true)}
            onPointerLeave={() => setMenuCharacterVisible(false)}
            content={name}
            setContent={setName}
            maxCharactor={MAX_CHARACTER_Name}
            placeholder="음식점 이름을 입력해주세요(최대 30자)"
          />
          {nameCharacterVisible && (
            <span className="float-right text-sm mt-1 text-gray-500 dark:text-gray-400">
              ({name.length}/{MAX_CHARACTER_Name})
            </span>
          )}
        </div>
      </div>

      <div className="mt-5">
        <div className="font-extrabold text-lg text-green-900 dark:text-slate-300 mb-1">
          가게 소개
        </div>
        <div className="m-1 p-1 max-w-full">
          <TextArea
            onFocus={() => setContentCharacterVisible(true)}
            onPointerLeave={() => setContentCharacterVisible(false)}
            content={description}
            setContent={setDiscription}
            rows={5}
            maxCharactor={MAX_CHARACTER_Description}
            placeholder="가게 설명을 작성해주세요(최대 300자)"
          />
          {contentCharacterVisible && (
            <span className="float-right text-sm mt-1 text-gray-500 dark:text-gray-400">
              ({description.length}/{MAX_CHARACTER_Description})
            </span>
          )}
        </div>
      </div>

      <div className="p-1 mx-1 mt-10 flex justify-between align-middle">
        <ImageUploadButtons maxNum={3} images={images} setImages={setImages} />
        <Button label={'제출하기'} onClick={handleSubmit} />
      </div>
    </>
  )
}
