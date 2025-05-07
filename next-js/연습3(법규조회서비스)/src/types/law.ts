// 법령
export type Law = {
  법령ID: string;
  법령명한글: string;
  개정이력: History[];
};

// 개정이력
export type History = {
  법령ID: string;
  법령명한글: string;
  법령일련번호: string;
  시행일자: string;
  공포일자: string;
};
