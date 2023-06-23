type ReviewModel = {
  id: string
  content: string
  rating: number
  userId?: string
  nickname?: string
  createdAt?: string
  createdBy?: string
}

export default ReviewModel
