// reference : https://next-auth.js.org/configuration/initialization#route-handlers-app

import GitHubProvider from "next-auth/providers/github";
import NextAuth, { NextAuthOptions } from "next-auth";

if (!process.env.GITHUB_CLIENT_ID || !process.env.GITHUB_CLIENT_SECRET){
    throw new Error("check .env file")
}

const authOptions: NextAuthOptions = {
    session: {
      strategy: "jwt",
    },
    providers: [
        GitHubProvider({
          clientId: process.env.GITHUB_CLIENT_ID,
          clientSecret: process.env.GITHUB_CLIENT_SECRET
        })
      ]
  };

const handler = NextAuth(authOptions);
export { handler as GET, handler as POST };
