import NextAuth from "next-auth"
import { PrismaAdapter } from '@next-auth/prisma-adapter';
import GoogleProvider from "next-auth/providers/google"
import NaverProvider from "next-auth/providers/naver"
import KakaoProvider from "next-auth/providers/kakao"
import prisma from "../../../../prisma/prisma_client";

export default NextAuth({
    adapter: PrismaAdapter(prisma),
    providers: [
        GoogleProvider({
            clientId: process.env.GOOGLE_CLIENT_ID || "",
            clientSecret: process.env.GOOGLE_CLIENT_SECRET || ""
        }),
        NaverProvider({
            clientId: process.env.NAVER_CLIENT_ID || "",
            clientSecret: process.env.NAVER_CLIENT_SECRET || ""
        }),
        KakaoProvider({
            clientId: process.env.KAKAO_CLIENT_ID || "",
            clientSecret: process.env.KAKAO_CLIENT_SECRET || ""
        }),
    ],
    pages: {
        signIn: "/auth"
    }
})