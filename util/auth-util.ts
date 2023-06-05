import { authOptions } from "@/app/api/auth/[...nextauth]/route";
import {getServerSession} from "next-auth"

export const getLoginUserEmail = async () => {
    // check user logined or not
    const session = await getServerSession(authOptions)
    return session?.user?.email
}