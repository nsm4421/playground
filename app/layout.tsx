import type { Metadata } from "next";
import { Space_Grotesk } from "next/font/google";
import "./globals.css";

import ThemeProvider from "@/components/provider/theme-provider";
import { cn } from "@/lib/utils";
import NextAuthProvider from "@/components/provider/auth-provider";
import { ReactNode } from "react";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth/auth";
import SignInButton from "@/components/auth/sign_in_button";
import LoginMenu from "@/components/auth/login_menu";

// 글씨체
const font = Space_Grotesk({
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "Karma",
  description: "채팅 어플 만들기",
};

interface Props {
  children: ReactNode;
}

export default async function RootLayout(props: Props) {
  const session = await getServerSession(authOptions);

  return (
    <html lang="en" suppressHydrationWarning>
      <body className={cn(font.className)}>
        {/* ShadCN 테마 적용 */}
        <ThemeProvider
          defaultTheme="dark"
          enableSystem
          disableTransitionOnChange
        >
          {/* 세션 적용 */}
          <NextAuthProvider>
            {/* 최대 넓이 */}
            <main className="max-w-4xl mx-auto h-screen">
              {session?.user ? props.children : <LoginMenu />}
            </main>
          </NextAuthProvider>
        </ThemeProvider>
      </body>
    </html>
  );
}
