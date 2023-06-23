'use client'

import IconButton from '@/components/icon-button-component'
import RestaurantModel from '@/util/model/restaurant-model'
import axios from 'axios'
import { useSession } from 'next-auth/react'
import Link from 'next/link'
import { HiPencil, HiTrash } from 'react-icons/hi2'

export default function RestaurantItem(props: {
  restaurant: RestaurantModel
  refetch: () => void
}) {
  const { data: session } = useSession()
  const handleDelete = async () => {
    await axios
      .delete(`/api/restaurant?restaurantId=${props.restaurant.id}`)
      .catch(console.error)
  }

  return (
    <div className="bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700">
      {/* TODO : 이미지 보여주기 */}
      {/* <img
            className="rounded-t-lg"
            src="/docs/images/blog/image-1.jpg"
            alt=""
          /> */}

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

        {/* 음식점 설명 */}
        <p className="mb-3 font-normal text-gray-700 dark:text-gray-400">
          {props.restaurant.description}
        </p>
      </div>
    </div>
  )
}
