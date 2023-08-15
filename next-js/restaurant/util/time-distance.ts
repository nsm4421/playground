import { formatDistanceToNow } from 'date-fns'
import { ko } from 'date-fns/locale'

export default function koreanTimeDistance(dt: Date) {
  return formatDistanceToNow(dt, { locale: ko }) + '전'
}
