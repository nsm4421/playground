'use client'

import Pagination from '@/components/atom/pagination-component'
import StartRating from '@/components/atom/rating-star-component'
import ReviewModel from '@/util/model/review-model'
import koreanTimeDistance from '@/util/time-distance'
import { useEffect, useState } from 'react'
import useAxios from '@/util/hook/use-axios'
import { HiTrash } from 'react-icons/hi2'
import IconButton from '@/components/atom/icon-button-component'
import { useSession } from 'next-auth/react'
import axios from 'axios'
import Image from 'next/image'
import { useRecoilState, useRecoilValue } from 'recoil'
import _lastFetchedAt from './review-state'
import deleteFile from '@/util/db/s3/s3-delete'

interface ResponseData {
  reviews: ReviewModel[]
  totalCount: number
}

export default function ReivewList(props: { restaurantId: string }) {
  const lastModifiedAt = useRecoilValue(_lastFetchedAt)
  const [page, setPage] = useState<number>(1)
  const { data, error, isLoading, refetch } = useAxios<ResponseData>({
    url: `/api/review?restaurantId=${props.restaurantId}&page=${page}`,
    method: 'GET',
  })

  // page나 lastModfiedAt이 변경되면, 서버로부터 리뷰데이터 refetch
  useEffect(() => {
    refetch()
  }, [page, lastModifiedAt])

  if (isLoading || error || !data?.reviews || !data?.totalCount) return

  return (
    <div className="p-1">
      {data.reviews.map((review: ReviewModel, idx: number) => (
        <ReviewItem key={idx} review={review} />
      ))}
      <div className="my-8">
        <Pagination
          page={page}
          setPage={setPage}
          totalCount={data.totalCount}
        />
      </div>
    </div>
  )
}

function ReviewItem(props: { review: ReviewModel }) {
  const { data: session } = useSession()
  const [_, setLastFetched] = useRecoilState(_lastFetchedAt)
  // 리뷰삭제 기능
  const handleDelete = async () => {
    await axios
      .delete(`/api/review?reviewId=${props.review.id}`)
      .then(() => {
        // 최종 Fetch된 시간 Update → 리뷰 데이터 refetch
        setLastFetched(Date.now())
        // S3 Bucket에 저장된 데이터 삭제 요청
        props.review.images?.split(',').map((image) => deleteFile(image))
      })
      .catch(console.error)
  }
  return (
    <div className="shadow-slate-300 dark:shadow-slate-700 border-b-2 mt-1 mb-1 pt-3 pb-3 dark:border-b-slate-600">
      <div className="mt-2 flex justify-between ">
        {/* 작성자 닉네임 */}
        <div>
          <span>{props.review.nickname ?? '익명'}</span>
          {props.review.createdAt && (
            <span className="ml-3 text-gray-500 dark:text-gray-400">
              {koreanTimeDistance(new Date(props.review.createdAt))}
            </span>
          )}
        </div>
        {/* 작성자인 경우 삭제 버튼 */}
        {session?.user.id === props.review.userId && (
          <div className="flex justify-start">
            <IconButton
              onClick={handleDelete}
              icon={<HiTrash />}
              className="text-xl hover:text-blue-600 hover:dark:text-blue-300"
            />
          </div>
        )}
      </div>
      {/* 별점 */}
      <div className="mt-2">
        <StartRating min={1} max={5} rating={props.review.rating} />
      </div>
      {/* 리뷰 내용 */}
      <div className="mt-2 break-words">
        <p className="whitespace-normal">{props.review.content}</p>
      </div>
    </div>
  )
}
