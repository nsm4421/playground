'use client'

import { ImCross } from 'react-icons/im'
import { useRecoilState } from 'recoil'
import { lastReviewFetchedAt, restaurantIdForWriteReview } from './review-state'
import { useState } from 'react'
import uploadImageAndReturnFilename from '@/util/db/s3/s3-upload-file'
import axios from 'axios'
import StartRating from '@/components/atom/rating-star-component'
import Button from '@/components/atom/button-component'
import TextArea from '@/components/atom/text-area-component'
import Input from '@/components/atom/input-component'

const MAX_CHARACTER_MENU = 30 // 메뉴 input 글자 최대길이
const MAX_CHARACTER_CONTENT = 300 // 리뷰 input 글자 최대길이

// 리뷰작성 모달
export default function WriteReviewModal() {
  /**
   * RecoilState
   * restaurantId : 리뷰작성 버튼을 누른 음식점 게시글의 id
   * setLastFetched : 가장 마지막 리뷰를 가져온 시간 → 해당 state 업데이트 시 리뷰 refetch
   */
  const [restaurantId, setRestaurantId] = useRecoilState(
    restaurantIdForWriteReview
  )
  const [_, setLastFetched] = useRecoilState(lastReviewFetchedAt)

  /**
   * State
   * menu : 메뉴
   * content : 본문
   * rating : 별점
   * menuCharacterVisible : 메뉴 글자수 제한 보여주기
   * contentCharacterVisible : 본문 글자수 제한 보여주기
   */
  const [menu, setMenu] = useState<string>('')
  const [content, setContent] = useState<string>('')
  const [rating, setRating] = useState<number>(5)
  const [menuCharacterVisible, setMenuCharacterVisible] =
    useState<boolean>(false)
  const [contentCharacterVisible, setContentCharacterVisible] =
    useState<boolean>(false)

  const handleClose = () => {
    setRestaurantId(null)
  }

  // 리뷰 저장
  const handleSubmit = async () => {
    // DB에 저장
    await axios
      .post('/api/review', {
        restaurantId,
        content,
        menu,
        rating,
      })
      .then(() => {
        setRestaurantId(null)
        setLastFetched(Date.now())
      })
      .catch(console.error)
  }

  if (!restaurantId) return

  return (
    <div className="flex justify-center fixed top-0 left-0 right-0 z-50 w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full">
      <div className="relative w-full max-w-3xl max-h-full mt-10">
        <div className="relative bg-white rounded-lg shadow dark:bg-gray-600">
          <div className="max-w-full  shadow-md shadow-slate-200 dark:shadow-slate-500 p-2">
            {/* hEADER */}
            <div className="mt-5 mb-2 text-3xl font-bold text-center">
              이 가게를 추천하시겠어요?
              {/* 닫기 버튼 */}
              <button
                onClick={handleClose}
                type="button"
                className="float-right text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
              >
                <ImCross />
              </button>
            </div>

            {/* 리뷰작성 양식 */}
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

            <div className="mt-8 mb-3 flex justify-end">
              <Button label={'리뷰등록'} onClick={handleSubmit} />
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
