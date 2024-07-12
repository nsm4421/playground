import Loadings from "@/components/auth/loadings";
import NotAuthenticated from "@/components/auth/not_authenticated";
import { signOut, useSession } from "next-auth/react";
import { useRouter } from "next/router";

export default function Home() {

  const router = useRouter()

  const { data: session, status } = useSession()
  const handleGoToLogin = () => router.push("/auth")
  const handleSignOut = () => signOut()

  switch (status) {
    case "loading":
      return <Loadings/>
    case "unauthenticated":
      return <NotAuthenticated/>
    case "authenticated":
      return (
        <main>
          <p>current user : {session?.user?.email}</p>
          <button onClick={handleGoToLogin}>Go To Login Page</button>
          <button onClick={handleSignOut}>Sign Out</button>
        </main>
      );
  }
}