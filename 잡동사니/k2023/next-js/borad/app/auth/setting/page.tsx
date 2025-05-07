import SetNickname from "./set-nickname";
import { getServerSession } from "next-auth";
import { authOptions } from "@/app/api/auth/[...nextauth]/route";
import NotAuthorizedComponent from "@/components/not-authorized-component";

export default async function Setting() {
  const session = await getServerSession(authOptions);

  // not logined
  if (!session?.user) return <NotAuthorizedComponent />;

  // logined
  return (
    <>
      <SetNickname />
    </>
  );
}
