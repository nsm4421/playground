import ReivewList from './get-reviews'
import ReviewForm from './review-form'
import ResturantNav from './restaurant-nav'

interface Params {
  params: { restaurantId: string }
}

export default async function CreateReview({ params }: Params) {
  return (
    <>
      {/* Nav */}
      <section className="mt-2 mb-10 flex justify-center p-2">
        <div className="max-w-3xl w-full">
          <ResturantNav {...params} />
        </div>
      </section>

      <section className="flex justify-center">
        <div className="max-w-3xl w-full shadow-md shadow-slate-200 dark:shadow-slate-500 p-2">
          <div className="text-3xl font-bold text-center">
            이 가게를 추천하시겠어요?
          </div>

          {/* 리뷰작성 양식 */}
          <section className="flex justify-center mt-2">
            <div className="max-w-3xl w-full">
              <ReviewForm {...params} />
            </div>
          </section>

          {/* 기존댓글 */}
          <div className="flex justify-center mt-5">
            <div className="max-w-3xl w-full">
              <ReivewList {...params} />
            </div>
          </div>
        </div>
      </section>
    </>
  )
}
