import { fireAuth } from "@/data/remote/firebase";
import { createUserWithEmailAndPassword } from "firebase/auth";
import { NextApiRequest, NextApiResponse } from "next";
import { SignUpResponse } from ".";

type SignUpRequest = {
    email: string;
    password: string;
}

export async function POST(
    req: NextApiRequest,
    res: NextApiResponse<SignUpResponse>
) {
    try {
        const { email, password }: SignUpRequest = req.body
        await createUserWithEmailAndPassword(fireAuth, email, password)
        return res.status(200).json({ message: "sign up with email and password success" })
    } catch (err) {
        return res.status(500).send({ message: "sign up with email and password fail" })
    }
}