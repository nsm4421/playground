'use client'
import Button from '@/components/button-component'
import ImageUploadButtons from '@/components/image-upload-button'

import TextArea from '@/components/text-area-component'
import { useEffect, useState } from 'react'
import Input from '@/components/input-component'
import { useRouter } from 'next/navigation'
import DropDownSlider from '@/components/dropdown-slider-component'
import axios from 'axios'
import categoriesItem from '@/util/model/category-items'
import RestaurantModel from '@/util/model/restaurant-model'

const MAX_CHARACTER_Name = 30
const MAX_CHARACTER_Description = 300

export default function RestaurantForm(props: { restaurantId: string }) {
  const router = useRouter()
  const [name, setName] = useState<string>('')
  const [selected, setSelected] = useState<number>(-1)
  const [description, setDescription] = useState<string>('')
  const [images, setImages] = useState<string[]>([])
  const [nameCharacterVisible, setMenuCharacterVisible] =
    useState<boolean>(false)
  const [contentCharacterVisible, setContentCharacterVisible] =
    useState<boolean>(false)

  const init = async () => {
    const res: RestaurantModel = await axios
      .get(`/api/restaurant?restaurantId=${props.restaurantId}`)
      .then((res) => res.data.restaurant)
    categoriesItem.map((item, idx) => {
      if (item === res.category) setSelected(idx)
    })
    setName(res.name)
    setDescription(res.description)
  }

  const handleSubmit = async () => {
    await axios
      .put('/api/restaurant', {
        name,
        category: selected === -1 ? null : categoriesItem[selected],
        description,
        ...props,
      })
      .then(() => {
        router.push('/restaurant')
        return
      })
      .catch(console.error)
  }

  useEffect(() => {
    init()
  }, [])

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
            setContent={setDescription}
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
