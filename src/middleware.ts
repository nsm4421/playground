export { default } from "next-auth/middleware"

// auth를 제외한 모든 경로에 대해
// 인증되지 않은 접근은 로그인페이지로
export const config = { matcher:['/((?!auth).*)']}