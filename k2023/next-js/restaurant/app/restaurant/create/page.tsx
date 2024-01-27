import RestaurantEditComponent from '@/components/restaurant-edit-component'

export default function CreateRestaurant() {
  return (
    <div className="flex justify-center p-2">
      <div className="max-w-5xl w-full">
        <div className="mt-2 mb-10">
          <h1 className="font-extrabold text-3xl">가게 추가하기</h1>
        </div>
        <RestaurantEditComponent label={'추가'} />
      </div>
    </div>
  )
}
