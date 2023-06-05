// reference : https://next-auth.js.org/configuration/initialization#route-handlers-app

import GitHubProvider from "next-auth/providers/github";
import NextAuth, { NextAuthOptions } from "next-auth";
import { MongoDBAdapter } from "@next-auth/mongodb-adapter";
import { connectDB } from "@/util/database";

if (!process.env.NEXTAUTH_SECRET || !process.env.GITHUB_CLIENT_ID || !process.env.GITHUB_CLIENT_SECRET){
    throw new Error("check .env file")
}

export const authOptions: NextAuthOptions = {
    secret:process.env.NEXTAUTH_SECRET,
    adapter:MongoDBAdapter(connectDB),
    providers: [
        GitHubProvider({
          clientId: process.env.GITHUB_CLIENT_ID,
          clientSecret: process.env.GITHUB_CLIENT_SECRET
        })
      ]
  };

const handler = NextAuth(authOptions);
export { handler as GET, handler as POST };
