'use client'

import Pagination from '@/components/pagination-component'
import StartRating from '@/components/rating-star-component'
import ReviewModel from '@/util/model/review-model'
import koreanTimeDistance from '@/util/time-distance'
import { useState } from 'react'
import useAxios from '@/util/hook/use-axios'

interface ResponseData {
  reviews: ReviewModel[]
  totalCount: number
}

export default function ReivewList(props: { restaurantId: number }) {
  const [page, setPage] = useState<number>(1)
  const { data, error, isLoading } = useAxios<ResponseData>({
    url: `/api/review?restaurantId=${props.restaurantId}&page=${page}`,
    method: 'GET',
  })

  // TODO : Loading, Error Component
  if (isLoading) return <div>Loadings...</div>
  if (error || !data.reviews || !data.totalCount) return <div>Error...</div>

  return (
    <>
      {data.reviews.map((review: ReviewModel, idx: number) => (
        <Review key={idx} review={review} />
      ))}
      <Pagination page={page} setPage={setPage} totalCount={data.totalCount} />
    </>
  )
}

function Review(props: { review: ReviewModel }) {
  return (
    <>
      <div className="mt-2">
        <span>{props.review.nickname ?? '익명'}</span>
        <span className="ml-3 text-gray-500 dark:text-gray-400">
          {koreanTimeDistance(new Date(props.review.createdAt))}
        </span>
      </div>
      <div className="mt-2">
        <StartRating min={1} max={5} rating={props.review.rating} />
      </div>
      <div className="mt-2">
        <div>{props.review.content}</div>
      </div>
    </>
  )
}
