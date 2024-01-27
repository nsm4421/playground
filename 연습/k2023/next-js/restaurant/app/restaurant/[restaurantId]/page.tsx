import RestaurantEditComponent from '@/components/restaurant-edit-component'

interface Params {
  params: { restaurantId: string }
}

export default function RestaurantDetail({ params }: Params) {
  return (
    <div className="flex justify-center p-2">
      <div className="max-w-5xl w-full">
        <div className="mt-2 mb-10">
          <h1 className="font-extrabold text-3xl">가게 정보 수정하기</h1>
        </div>
        <RestaurantEditComponent {...params} label={'수정'} />
      </div>
    </div>
  )
}
