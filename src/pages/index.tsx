import { signOut, useSession } from "next-auth/react";
import { useRouter } from "next/router";

export default function Home() {

  const router = useRouter()

  const { data } = useSession()
  const handleGoToLogin = () => router.push("/auth")
  const handleSignOut = () => signOut()

  // 로그인한 경우
  return (
    <main>
      <p>current user : {data?.user?.email}</p>
      <button onClick={handleGoToLogin}>Go To Login Page</button>
      <button onClick={handleSignOut}>Sign Out</button>
    </main>
  );
}