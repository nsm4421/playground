'use client'

import Carousel from '@/components/atom/carousel-component'
import IconButton from '@/components/atom/icon-button-component'
import RestaurantModel from '@/util/model/restaurant-model'
import axios from 'axios'
import { useSession } from 'next-auth/react'
import Link from 'next/link'
import { useState } from 'react'
import { HiChevronDown, HiChevronUp, HiPencil, HiTrash } from 'react-icons/hi2'
import Review from './review'

export default function RestaurantItem(props: {
  restaurant: RestaurantModel
  refetch: () => void
}) {
  const { data: session } = useSession()
  const [isAccordianOpen, setAccordianOpen] = useState<boolean>(false)
  const handleIsAccordianOpen = () => {
    setAccordianOpen(!isAccordianOpen)
  }
  const handleDelete = async () => {
    await axios
      .delete(`/api/restaurant?restaurantId=${props.restaurant.id}`)
      .catch(console.error)
  }
  return (
    <div className="pt-5 bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-600 dark:border-gray-700">
      {/* Carousel */}
      {props.restaurant.images && (
        <Carousel images={props.restaurant.images.split(',')} height={56} />
      )}
      <div className="p-5">
        <div className="flex justify-between">
          {/* 음식점 이름 */}
          <h5 className="cursor-pointer mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white hover:text-orange-500">
            <Link href={`/review/${props.restaurant.id}`}>
              {props.restaurant.name}
            </Link>
          </h5>
          {/* 수정 페이지 이동, 삭제버튼 */}
          {session?.user.id === props.restaurant.createdBy && (
            <div>
              <Link href={`/restaurant/${props.restaurant.id}`}>
                <IconButton
                  className="mr-5 text-xl hover:text-blue-600 hover:dark:text-blue-300"
                  icon={<HiPencil />}
                />
              </Link>
              <IconButton
                onClick={handleDelete}
                className="text-xl hover:text-blue-600 hover:dark:text-blue-300"
                icon={<HiTrash />}
              />
            </div>
          )}
        </div>
        <div className="flex justify-between">
          {/* 음식점 설명 */}
          <p className="mb-3 font-normal text-gray-700 dark:text-gray-400">
            {props.restaurant.description}
          </p>
          <IconButton
            onClick={handleIsAccordianOpen}
            className="bg-transparent hover:text-orange-400"
            icon={
              isAccordianOpen ? (
                <HiChevronUp className="text-xl font-extrabold" />
              ) : (
                <HiChevronDown className="text-xl font-extrabold" />
              )
            }
          />
        </div>
        {/* Accordian이 열리면 리뷰 보여주기 */}
        {isAccordianOpen && <Review restaurantId={props.restaurant.id} />}
      </div>
    </div>
  )
}
