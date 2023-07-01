import { atom } from 'recoil'

// 데이터를 가장 마지막으로 가져온 시간
// UseEffect hook을 사용해 해당 State 변경 시 데이터를 다시 가져오도록 함
const lastFetchedAt = atom({
  key: 'last-fetched-at',
  default: Date.now(),
})

export default lastFetchedAt
