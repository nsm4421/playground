import useFirebaseAuth from "@/util/hook/use_firebase_auth";
import Link from "next/link";

export default function Home() {

  const { currentUser, isLoading, signOut } = useFirebaseAuth()

  // 로딩중
  if (isLoading) {
    return <div>Loadings...</div>
  }

  // 로그인하지 않은 경우
  if (!currentUser) {
    return <div>
      <h1>Need to login</h1>
      <Link href={"/auth"}>Go to auth page</Link>
    </div>
  }

  // 로그인한 경우
  return (
    <main>
      <div>
        {currentUser.email}
      </div>

      <button onClick={signOut}>
        Sign Out
      </button>
    </main>
  );
}
