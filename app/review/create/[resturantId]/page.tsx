import ReviewForm from './review-form'

export default function CreateReview() {
  return (
    <>
      <div className="text-3xl font-bold text-center">
        이 가게를 추천하시겠어요?
      </div>

      {/* 리뷰작성 양식 */}
      <section className="flex justify-center mt-2">
        <div className="max-w-3xl w-full">
          <ReviewForm />
        </div>
      </section>

      {/* 기존댓글 */}
      <section></section>
    </>
  )
}
