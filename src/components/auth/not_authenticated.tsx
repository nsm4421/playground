import { useRouter } from "next/router"

export default function NotAuthenticated() {
    const router = useRouter()
    const handleGoToLoginPage = () => router.push("/auth")
    return <main className="w-full h-full mt-10 p-3">
        <h1 className="text-3xl font-bold">로그인이 되지 않았습니다</h1>
        <button className="p-2 mt-5 rounded-lg text-slate-50 bg-slate-800 hover:bg-slate-600 text-xl" onClick={handleGoToLoginPage}>로그인 페이지로</button>
    </main>
}