import { signOut, useSession } from "next-auth/react";
import { useRouter } from "next/router";

export default function Home() {

  const { data } = useSession()
  const router = useRouter()
  const handleSignOut = () => signOut()

  // 로그인이 필요한 경우
  if (data?.user == null) {
    router.push("/auth")
    return
  }

  // 로그인한 경우
  return (
    <main>
      <p>current user : {data.user.email}</p>
      <button onClick={handleSignOut}>Sign Out</button>
    </main>
  );
}