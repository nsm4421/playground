'use client'

import ReivewList from './review-list'
import { MdRateReview } from 'react-icons/md'
import IconButton from '@/components/atom/icon-button-component'
import { HiPencil } from 'react-icons/hi2'
import WriteReviewModal from './write-review-modal'
import { useRecoilState } from 'recoil'
import { restaurantIdForWriteReview } from './review-state'

export default function Review(props: { restaurantId: string }) {
  const [_, setRestaurantId] = useRecoilState(restaurantIdForWriteReview)
  const handleRestaurantId = () => {
    setRestaurantId(props.restaurantId)
  }
  if (!props.restaurantId) return
  return (
    <div className="flex justify-center shadow-lg bg-slate-100 dark:bg-slate-700 rounded-md mt-5">
      {/* 리뷰입력 모달창 */}
      <WriteReviewModal />
      {/* 헤더 */}
      <div className="w-full p-3">
        <div className="flex justify-between">
          <div className="flex">
            <MdRateReview className="text-xl font-bold mt-1 mr-1" />
            <h3 className="text-xl font-bold">리뷰</h3>
          </div>
          <IconButton
            onClick={handleRestaurantId}
            className="bg-transparent flex font-semibold hover:text-orange-400"
            icon={<HiPencil className="mt-1 mr-2" />}
            label="리뷰작성"
          />
        </div>

        {/* 기존댓글 */}
        <div className="mt-3 shadow-md shadow-slate-200 dark:shadow-slate-500 p-2">
          <ReivewList {...props} />
        </div>
      </div>
    </div>
  )
}
