import RestaurantModel from '@/util/model/restaurant-model'
import Link from 'next/link'

export default function RestaurantItem(props: { restaurant: RestaurantModel }) {
  return (
    <div className="max-w-sm bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700">
      {/* TODO : 이미지 보여주기 */}
      {/* <img
            className="rounded-t-lg"
            src="/docs/images/blog/image-1.jpg"
            alt=""
          /> */}

      <div className="p-5">
        <h5 className="cursor-pointer mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white hover:text-orange-500">
          <Link href={`/restaurant/${props.restaurant.id}`}>
            {props.restaurant.name}
          </Link>
        </h5>

        <p className="mb-3 font-normal text-gray-700 dark:text-gray-400">
          {props.restaurant.description}
        </p>
      </div>
    </div>
  )
}
