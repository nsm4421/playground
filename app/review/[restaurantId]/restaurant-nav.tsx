'use client'

import useAxios from '@/util/hook/use-axios'
import RestaurantModel from '@/util/model/restaurant-model'
import Link from 'next/link'

interface Props {
  restaurantId: number
}

export default function ResturantNav(props: Props) {
  const {
    data: restaurant,
    isLoading,
    error,
  } = useAxios<RestaurantModel>({
    url: `/api/restaurant?restaurantId=${props.restaurantId}`,
    method: 'GET',
  })

  // TODO : Loading, Error Component
  if (isLoading) return <h1>Loadings...</h1>
  if (error || !restaurant) return <h1>Error...</h1>

  return (
    <nav className="p-2 shadow-sm shadow-gray-500 dark:shadow-slate-500">
      <div className="text-3xl font-extrabold hover:text-orange-400">
        <Link href={`/restaurant/${props.restaurantId}`}>
          {restaurant.name}
        </Link>
      </div>
      <div className="text-xl text-gray-700 dark:text-slate-300 mt-5">
        {restaurant.description}
      </div>
      <div className="text-gray-800 dark:text-slate-500 mt-5">
        {restaurant.location}
      </div>
    </nav>
  )
}
