'use client'

import Pagination from '@/components/pagination-component'
import StartRating from '@/components/rating-star-component'
import ReviewModel from '@/util/model/review-model'
import koreanTimeDistance from '@/util/time-distance'
import { useState } from 'react'
import useAxios from '@/util/hook/use-axios'
import { HiTrash } from 'react-icons/hi2'
import IconButton from '@/components/icon-button-component'
import { useSession } from 'next-auth/react'
import axios from 'axios'

interface ResponseData {
  reviews: ReviewModel[]
  totalCount: number
}

export default function ReivewList(props: { restaurantId: string }) {
  const [page, setPage] = useState<number>(1)
  const { data, error, isLoading } = useAxios<ResponseData>({
    url: `/api/review?restaurantId=${props.restaurantId}&page=${page}`,
    method: 'GET',
  })

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
  const handleDelete = async () => {
    await axios
      .delete(`/api/review?reviewId=${props.review.id}`)
      .catch(console.error)
  }
  return (
    <div className="shadow-slate-300 dark:shadow-slate-700">
      <div className="mt-2 flex justify-between ">
        <div>
          <span>{props.review.nickname ?? '익명'}</span>
          {props.review.createdAt && (
            <span className="ml-3 text-gray-500 dark:text-gray-400">
              {koreanTimeDistance(new Date(props.review.createdAt))}
            </span>
          )}
        </div>
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
      <div className="mt-2">
        <StartRating min={1} max={5} rating={props.review.rating} />
      </div>
      <div className="mt-2 break-words">
        <p className="whitespace-normal">{props.review.content}</p>
      </div>
    </div>
  )
}
