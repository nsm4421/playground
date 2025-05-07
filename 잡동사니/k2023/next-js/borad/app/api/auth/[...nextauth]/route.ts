// reference : https://next-auth.js.org/configuration/initialization#route-handlers-app
import GitHubProvider from "next-auth/providers/github";
import CredentialsProvider from "next-auth/providers/credentials";
import NextAuth, { NextAuthOptions } from "next-auth";
import { MongoDBAdapter } from "@next-auth/mongodb-adapter";
import { connectDB } from "@/util/database";
import bcrypt from "bcrypt";
import { ObjectId } from "mongodb";

if (
  !process.env.NEXTAUTH_SECRET ||
  !process.env.GITHUB_CLIENT_ID ||
  !process.env.GITHUB_CLIENT_SECRET
) {
  throw new Error("check .env file");
}

export const authOptions: NextAuthOptions = {
  secret: process.env.NEXTAUTH_SECRET,
  adapter: MongoDBAdapter(connectDB),
  providers: [
    /// email & password
    CredentialsProvider({
      name: "credentials",
      credentials: {
        email: {
          label: "Email",
          type: "text",
          placeholder: "example@naver.com",
        },
        password: {
          label: "Password",
          type: "password",
          placeholder: "1q2w3e4r!",
        },
      },
      async authorize(credentials) {
        // find user by email
        const db = (await connectDB).db(process.env.DB_NAME);
        const user = await db
          .collection("users")
          .findOne({ email: credentials?.email })
          .then((doc) => ({
            id: String(doc?._id),
            email: doc?.email,
            password: doc?.password,
            image: doc?.image ?? null,
            role: doc?.role ?? "USER",
          }));

        // user information is not valid
        if (!user.id || !user.email || !user.password) return null;

        // password is invalid
        if (!credentials?.password) return null;
        if (!(await bcrypt.compare(credentials.password, user?.password)))
          return null;

        // return user
        return user;
      },
    }),
    /// github
    GitHubProvider({
      clientId: process.env.GITHUB_CLIENT_ID,
      clientSecret: process.env.GITHUB_CLIENT_SECRET,
    }),
  ],
  session: {
    strategy: "jwt",
    maxAge: 7 * 24 * 60 * 60, // 7days
  },

  callbacks: {
    // async signIn({ user }) {
    //   try {
    //     const db = (await connectDB).db(process.env.DB_NAME);
    //     await db
    //       .collection("users")
    //       .updateOne({ _id: new ObjectId(user.id) }, { $set: { ...user } }, { upsert: true });
    //     return true;
    //   } catch (err) {
    //     console.error(err);
    //     return false;
    //   }
    // },
    jwt: async ({ token, user }) => {
      if (user) {
        token.user = { ...user };
      }
      return token;
    },
    async session({ session, token }) {
      if (token.user) {
        session.user = { ...token.user };
      }
      return session;
    },
  },
};

const handler = NextAuth(authOptions);
export { handler as GET, handler as POST };
