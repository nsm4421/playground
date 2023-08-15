import NextAuth from "next-auth/next";
import CredentialsProvider from "next-auth/providers/credentials";

const handler = NextAuth({
  providers: [
    CredentialsProvider({
      id: "email-password-credentials",
      credentials: {
        email: {
          label: "Email",
          type: "text",
          placeholder: "hello@example.com",
        },
        password: {
          label: "Password",
          type: "password",
          placeholder: "1q2w3e4r!",
        },
      },
      async authorize(credentials, req) {
        const res = await fetch("http://localhost:3000/api/auth/login", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            email: credentials?.email,
            password: credentials?.password,
          }),
        });
        const json = await res.json();
        const user = json.data;
        if (!user) {
          throw new Error(json.message);
        }
        return user;
      },
    }),
  ],
  pages: {
    signIn: "/auth/login", // custom login page
  },
  callbacks: {
    async jwt({ token, user }) {
      return { ...token, ...user };
    },
    async session({ session, token }) {
      session.user = token as any;
      return session;
    },
  },
});

export { handler as GET, handler as POST };
