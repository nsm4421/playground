'use client'

import useAxios from '@/util/hook/use-axios'
import RestaurantModel from '@/util/model/restaurant-model'
import Link from 'next/link'

export default function ResturantNav(props: { restaurantId: string }) {
  const { data, isLoading, error } = useAxios<{
    restaurant: RestaurantModel
  }>({
    url: `/api/restaurant?restaurantId=${props.restaurantId}`,
    method: 'GET',
  })

  // TODO : Loading, Error Component
  if (isLoading) return <h1>Loadings...</h1>
  if (error || !data?.restaurant) return <h1>Error...</h1>

  return (
    <nav className="p-2 shadow-sm shadow-gray-500 dark:shadow-slate-500">
      <div className="text-3xl font-extrabold hover:text-orange-400">
        <Link href={`/restaurant/${props.restaurantId}`}>
          {data.restaurant.name}
        </Link>
      </div>
      <div className="text-xl text-gray-700 dark:text-slate-300 mt-5">
        {data.restaurant.description}
      </div>
      <div className="text-gray-800 dark:text-slate-500 mt-5">
        {data.restaurant.location}
      </div>
    </nav>
  )
}
