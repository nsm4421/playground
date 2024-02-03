import { signIn, useSession } from "next-auth/react";
import { useRouter } from "next/router";

export default function AuthPage() {

    const router = useRouter()

    const { data } = useSession();

    const handleGoogleSignIn = () => signIn('google')

    // 이미 로그인한 경우
    if (data?.user) {
        router.push("/")
    }

    // 로그인하지 않은 경우
    return <div>
        <h1>Auth Page</h1>
        <button onClick={handleGoogleSignIn}>Google Sign In</button>
    </div>
}