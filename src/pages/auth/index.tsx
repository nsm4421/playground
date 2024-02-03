import { signIn, signOut, useSession } from "next-auth/react";
import { useRouter } from "next/router";
import { useState } from "react";

type AuthProvider = "google" | "naver" | "kakao"

export default function AuthPage() {

    const [isLoading, setIsLoading] = useState<boolean>(false);

    const router = useRouter()

    const { data } = useSession();

    const handleSignIn = (provider: AuthProvider) => async () => {
        setIsLoading(true)
        try {
            await signIn(provider)
        } catch (err) {
            console.error(err)
        } finally {
            setIsLoading(false)
        }
    }
    const handleLogout = () => signOut()
    const handleGoHome = () => router.push('/')


    // 이미 로그인된 경우
    if (data?.user) {
        return <main className="flex flex-col justify-center px-5 lg:px-8 h-[60vh]">
            <div className="mx-auto w-full max-w-sm text-center">
                <h1 className="text-slate-900 font-bold text-3xl">로그인 되어 있습니다</h1>
                <label className="text-slate-700 font-bold text-xl">{data.user.email}</label>
                <ul className="mt-5 w-full justify-center">
                    <li className="my-2 mx-3">
                        <button
                            className="px-3 py-1 border-l w-full bg-rose-700 text-white rounded-lg hover:bg-rose-500"
                            onClick={handleGoHome} disabled={isLoading}>홈으로</button>
                    </li>
                    <li className="my-2 mx-3">
                        <button
                            className="px-3 py-1 border-l w-full bg-slate-700 text-white rounded-lg hover:bg-slate-500"
                            onClick={handleLogout} disabled={isLoading}>로그아웃</button>
                    </li>

                </ul>
            </div>
        </main>
    }

    // 소셜 로그인 페이지
    return <main className="flex flex-col justify-center px-5 lg:px-8 h-[60vh]">
        <div className="mx-auto w-full max-w-sm text-center">
            <h1 className="text-slate-900 font-bold text-3xl">소셜 로그인</h1>
            <label className="text-slate-700 font-bold text-xl">로그인 방법을 선택해주세요</label>

            <ul className="mt-10">
                <li className="my-2 mx-3">
                    <button
                        className="px-3 py-1 border-l w-full bg-sky-600 text-white rounded-lg hover:bg-sky-500"
                        onClick={handleSignIn("google")} disabled={isLoading}>구글 계정으로 로그인하기</button>
                </li>
                <li className="my-2 mx-3">
                    <button
                        className="px-3 py-1 border-l w-full bg-green-600 text-white rounded-lg hover:bg-gree-500"
                        onClick={handleSignIn("naver")} disabled={isLoading}>네이버 계정으로 로그인하기</button>
                </li>
                <li className="my-2 mx-3">
                    <button
                        className="px-3 py-1 border-l w-full bg-yellow-600 text-white rounded-lg hover:bg-yellow-500"
                        onClick={handleSignIn("kakao")} disabled={isLoading}>카카오 계정으로 로그인하기</button>
                </li>
            </ul>

        </div>
    </main>
}