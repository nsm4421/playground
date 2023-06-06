import { signIn } from "next-auth/react";
import SetNickname from "./set-nickname";
import { getServerSession } from "next-auth";
import { authOptions } from "@/app/api/auth/[...nextauth]/route";

export default async function Setting() {
  const session = await getServerSession(authOptions);

  const handleSignIn = () => {
    signIn();
  };

  // not logined
  if (!session?.user) {
    return (
      <>
        <h1>Need to login first</h1>
        <button onClick={handleSignIn}>Go to Sign in</button>
      </>
    );
  }
  // logined
  return (
    <>
      <h1>Setting</h1>
      <SetNickname/>
    </>
  );
}
