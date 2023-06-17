import ReivewList from './get-reviews'
import ReviewForm from './review-form'

interface Params {
  params: { restaurantId: number }
}

export default async function CreateReview({ params }: Params) {
  return (
    <>
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
      <section className="flex justify-center mt-5">
        <div className="max-w-3xl w-full">
          <ReivewList {...params} />
        </div>
      </section>
    </>
  )
}
