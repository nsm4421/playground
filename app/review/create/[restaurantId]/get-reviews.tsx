'use client'

import StartRating from '@/components/rating-star-component'
import ReviewModel from '@/util/model/review-model'
import koreanTimeDistance from '@/util/time-distance'
import axios from 'axios'
import { useEffect, useState } from 'react'

export default function ReivewList(props: { restaurantId: number }) {
  const [isLoading, setIsLoading] = useState(false)
  // TODO : pagination
  const [page, setPage] = useState<number>(1)
  const [reviews, setReviews] = useState<ReviewModel[]>([])

  const getReviews = async () => {
    setIsLoading(true)
    await axios
      .get(`/api/review?restaurantId=${props.restaurantId}&page=${page}`)
      .then((res) => res.data)
      .then((data: ReviewModel[]) => setReviews(data))
      .catch(console.error)
      .finally(() => {
        setIsLoading(false)
      })
  }

  useEffect(() => {
    getReviews()
  }, [])

  return (
    <>
      {reviews.map((review, idx) => (
        <Review key={idx} review={review} />
      ))}
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
