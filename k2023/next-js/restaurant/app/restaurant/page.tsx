import RecoilProvider from '@/components/provider/recoil-provider'
import ResutaurantItems from './restaurant-items'

export default function Restaurants() {
  return (
    <RecoilProvider>
      <div className="flex justify-center mt-5">
        <div className="max-w-4xl w-full">
          <ResutaurantItems />
        </div>
      </div>
    </RecoilProvider>
  )
}
