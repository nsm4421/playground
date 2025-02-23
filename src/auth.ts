import NextAuth from "next-auth";
import Credentials from "next-auth/providers/credentials";
import { ApiRoutes, RoutePaths } from "./lib/constant/route";
import { User } from "./lib/types/user";
import { NextResponse } from "next/server";

export const { handlers, signIn, signOut, auth } = NextAuth({
  pages: {
    signIn: RoutePaths.signIn,
    newUser: RoutePaths.signUp,
  },
  providers: [
    Credentials({
      credentials: {
        username: { label: "Username" },
        password: { label: "Password", type: "password" },
      },
      async authorize(credentials): Promise<User | null> {
        if (!credentials.username || !credentials.password) {
          console.error("username or password is not given");
          return null;
        }
        const endPoint = `${process.env.NEXT_PUBLIC_BASE_URL}${ApiRoutes.signIn.path}`;
        const response = await fetch(endPoint, {
          method: ApiRoutes.signIn.method,
          body: JSON.stringify({
            ...credentials,
          }),
        });
        if (!response.ok) return null;
        const user = await response.json();
        if (!user) return null;
        return {
          id: user.id,
          username: user.name,
          image: user.image,
        };
      },
    }),
  ],
});
