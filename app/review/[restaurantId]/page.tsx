import ReivewList from './review-list'
import ReviewForm from './review-form'
import ResturantNav from './restaurant-nav'
import RecoilProvider from '@/components/provider/recoil-provider'

interface Params {
  params: { restaurantId: string }
}

export default function CreateReview({ params }: Params) {
  return (
    <RecoilProvider>
      <div className="flex justify-center">
        <div className="max-w-3xl w-full">
          {/* Nav */}
          <div className="mt-3 mb-5">
            <ResturantNav {...params} />
          </div>

          {/* Edit */}
          <div className="shadow-md shadow-slate-200 dark:shadow-slate-500 p-2">
            <div className="text-3xl font-bold text-center mt-5 mb-2">
              이 가게를 추천하시겠어요?
            </div>
            {/* 리뷰작성 양식 */}
            <ReviewForm {...params} />
          </div>

          {/* 기존댓글 */}
          <div className="mt-3 shadow-md shadow-slate-200 dark:shadow-slate-500 p-2">
            <ReivewList {...params} />
          </div>
        </div>
      </div>
    </RecoilProvider>
  )
}
