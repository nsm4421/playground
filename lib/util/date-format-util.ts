export default function dateFormatUtil(timestampStr: string): string {
  const now = new Date();
  const timestamp = new Date(timestampStr);

  const diff = Math.floor((now.getTime() - timestamp.getTime()) / 1000); // 차이를 초 단위로 계산
  let result: string;

  if (diff < 60) {
    result = `${diff}초 전`;
  } else if (diff < 3600) {
    const minutes = Math.floor(diff / 60);
    result = `${minutes}분 전`;
  } else if (diff < 86400) {
    const hours = Math.floor(diff / 3600);
    result = `${hours}시간 전`;
  } else {
    const year = timestamp.getFullYear();
    const month = timestamp.getMonth() + 1;
    const date = timestamp.getDate();
    const hours = timestamp.getHours();
    const minutes = timestamp.getMinutes();

    result = `${year}.${month}.${date} ${hours}:${minutes}분`;
  }

  return result;
}
