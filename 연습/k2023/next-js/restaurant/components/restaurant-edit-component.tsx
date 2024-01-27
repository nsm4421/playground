'use client'

import categoriesItem from '@/util/model/category-items'
import RestaurantModel from '@/util/model/restaurant-model'
import axios from 'axios'
import { useRouter } from 'next/navigation'
import { useEffect, useState } from 'react'
import Input from './atom/input-component'
import DropDownSlider from './atom/dropdown-slider-component'
import TextArea from './atom/text-area-component'
import ImageUploadButtons from './atom/image-upload-button'
import Button from './atom/button-component'
import uploadImageAndReturnFilename from '@/util/db/s3/s3-upload-file'

interface Props {
  restaurantId?: string
  MAX_CHARACTER_NAME?: number
  MAX_CHARACTER_DESCRIPTiON?: number
  label?: string
}

/**
 * 음식점 게시글 작성 및 수정 Component
 * @param restaurantId  음식점 게시글 Id (있으면 게시글 수정, 없으면 게시글 신규작성)
 * @param MAX_CHARACTER_NAME 음식점 이름 최대 글자길이
 * @param MAX_CHARACTER_DESCRIPTiON 음식점 설명 최대 글자길이
 * @param label 제출 버튼 텍스트
 */
export default function RestaurantEditComponent(props: Props) {
  /** State
   * name : 음식점 이름
   * selected : 선택한 카테고리 index
   * description : 음식점 설명
   * images : 이미지
   * nameCharacterVisible : 음식점 이름에 입력한 글자 수 redering 여부
   * contentCharacterVisible : 음식점 설명에 입력한 글자 수 redering 여부
   */
  const router = useRouter()
  const [name, setName] = useState<string>('')
  const [selected, setSelected] = useState<number>(-1)
  const [description, setDescription] = useState<string>('')
  const [images, setImages] = useState<string[]>([])
  const [nameCharacterVisible, setMenuCharacterVisible] =
    useState<boolean>(false)
  const [contentCharacterVisible, setContentCharacterVisible] =
    useState<boolean>(false)

  // restaurant id가 안 주어지는 경우 → 게시글을 신규 작성
  // restaurant id가 주어지는 경우 → 기존 게시글을 수정
  useEffect(() => {
    // useEffect hook에서 asyc함수 사용하기 위해, hook내에서 함수를 정의해야 함
    const _init = async () => {
      if (!props.restaurantId) return
      const res: RestaurantModel = await axios
        .get(`/api/restaurant?restaurantId=${props.restaurantId}`)
        .then((res) => res.data.restaurant)
      categoriesItem.map((item, idx) => {
        if (item === res.category) setSelected(idx)
      })
      setName(res.name)
      setDescription(res.description)
    }
    _init()
  }, [])

  // 게시글 저장
  const handleSubmit = async () => {
    let imageUrls: string[] = []
    // 이미지 업로드
    try {
      // Bucket에 이미지 업로드 후 업로드한 이미지 경로 list로 반환
      for (const image of images) {
        const url = await uploadImageAndReturnFilename(image)
        if (url) imageUrls.push(url)
      }
      await axios({
        url: '/api/restaurant',
        method: props.restaurantId ? 'PUT' : 'POST',
        data: {
          name,
          category: selected === -1 ? null : categoriesItem[selected],
          description,
          ...(props.restaurantId && { restaurantId: props.restaurantId }),
          ...(imageUrls.length > 0 && { images: imageUrls.toString() }),
        },
      })
        .then(() => router.push('/restaurant'))
        .catch(console.error)
    } catch (err) {
      console.error(`Image upload Error \n ${err}`)
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
            maxCharactor={props.MAX_CHARACTER_NAME ?? 30}
            placeholder="음식점 이름을 입력해주세요(최대 30자)"
          />
          {nameCharacterVisible && (
            <span className="float-right text-sm mt-1 text-gray-500 dark:text-gray-400">
              ({name.length}/{props.MAX_CHARACTER_NAME ?? 30})
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
            maxCharactor={props.MAX_CHARACTER_DESCRIPTiON ?? 300}
            placeholder="가게 설명을 작성해주세요(최대 300자)"
          />
          {contentCharacterVisible && (
            <span className="float-right text-sm mt-1 text-gray-500 dark:text-gray-400">
              ({description.length}/{props.MAX_CHARACTER_DESCRIPTiON ?? 300})
            </span>
          )}
        </div>
      </div>

      <div className="p-1 mx-1 mt-10 flex justify-between align-middle">
        <ImageUploadButtons maxNum={3} images={images} setImages={setImages} />
        <Button label={props.label ?? '제출하기'} onClick={handleSubmit} />
      </div>
    </>
  )
}
