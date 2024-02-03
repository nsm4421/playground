import { fireAuth } from "@/data/remote/firebase";
import { signInWithEmailAndPassword } from "firebase/auth";
import { NextApiRequest, NextApiResponse } from "next";
import { SignUpResponse } from ".";

type SignInRequest = {
    email: string;
    password: string;
}

export default async function POST(
    req: NextApiRequest,
    res: NextApiResponse<SignUpResponse>
) {
    try {
        const { email, password }: SignInRequest = req.body
        await signInWithEmailAndPassword(fireAuth, email, password)
        return res.status(200).json({ message: "sign in success" })
    } catch (err) {
        return res.status(500).json({ message: "sign in fail" })
    }
}
