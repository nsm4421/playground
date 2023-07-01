type ReviewModel = {
  id: string
  content: string
  rating: number
  images?: string
  userId?: string
  nickname?: string
  createdAt?: string
  createdBy?: string
}

export default ReviewModel
