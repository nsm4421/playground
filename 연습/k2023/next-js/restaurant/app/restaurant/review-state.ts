import { atom } from 'recoil'

// 리뷰 작성할 음식점 아이디
export const restaurantIdForWriteReview = atom<string | null>({
  key: 'restaurant-id-for-write-review',
  default: null,
})

// 데이터를 가장 마지막으로 가져온 시간
// UseEffect hook을 사용해 해당 State 변경 시 데이터를 다시 가져오도록 함
export const lastReviewFetchedAt = atom<number>({
  key: 'last-fetched-at',
  default: Date.now(),
})
