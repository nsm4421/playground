import { formatDistance } from "date-fns";
import { ko } from "date-fns/locale";

export function parseLocalDateTimeInKoreanTime(localDateTimeString: string): string {
  const date = new Date(localDateTimeString);
  const distanceString = formatDistance(date, new Date(), { locale: ko });
  return distanceString + " 전"
}
