import CredentialsProvider from 'next-auth/providers/credentials'
import NextAuth, { NextAuthOptions } from 'next-auth'
import prisma from '@/util/db/prisma/prsima-client'
import { PrismaAdapter } from '@auth/prisma-adapter'
import { Adapter } from 'next-auth/adapters'
import bcrypt from 'bcrypt'

if (
  !process.env.NEXTAUTH_SECRET ||
  !process.env.GITHUB_CLIENT_ID ||
  !process.env.GITHUB_CLIENT_SECRET
) {
  throw new Error('check .env file')
}

if (!prisma) {
  throw new Error('prisma instance is not ')
}

export const authOptions: NextAuthOptions = {
  secret: process.env.NEXTAUTH_SECRET,
  adapter: PrismaAdapter(prisma) as Adapter,
  providers: [
    /// email & password
    CredentialsProvider({
      name: 'credentials',
      credentials: {
        email: {
          label: 'Email',
          type: 'text',
          placeholder: 'example@naver.com',
        },
        password: {
          label: 'Password',
          type: 'password',
          placeholder: '1q2w3e4r!',
        },
      },
      async authorize(credentials) {
        // check email exist
        const email = credentials?.email
        if (!email) return null
        // check user exist
        const user = await prisma.user.findUniqueOrThrow({ where: { email } })
        if (!user) return null
        // check password
        if (!user.password) return null
        if (!(await bcrypt.compare(credentials.password, user.password)))
          return null
        // sign up success
        return user
      },
    }),
  ],
  pages: {
    signIn: '/auth/sign-in', // custom sign in page
  },
  session: {
    strategy: 'jwt',
    maxAge: 7 * 24 * 60 * 60, // 7days
  },
  callbacks: {
    jwt: async ({ token, user }) => {
      if (user) {
        token.user = { ...user }
      }
      return token
    },
    async session({ session, token }) {
      if (token.user) {
        session.user = { ...token.user, ...session.user }
      }
      return session
    },
  },
}

const handler = NextAuth(authOptions)
export { handler as GET, handler as POST }
