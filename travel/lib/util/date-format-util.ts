/// 날짜를 2024-12-08와 같은 형태로 변경
export function formatDate({ dt, sep }: { dt: Date; sep?: string }) {
  const _sep = sep ?? "-";
  const year = dt.getFullYear();
  const month = String(dt.getMonth() + 1).padStart(2, "0");
  const day = String(dt.getDate()).padStart(2, "0");
  return `${year}${_sep}${month}${_sep}${day}`;
}

/// 날짜를 한국어로(~초전, ~분전, ~시간전, ...) 포맷팅하기
export function formatDateToKorean(timestampStr: string): string {
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
