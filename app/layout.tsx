import "./globals.css";
import { Inter } from "next/font/google";
import AuthSession from "@/components/auth-session";

const inter = Inter({ subsets: ["latin"] });

export const metadata = {
  title: "Hobby",
  description: "next app",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <AuthSession>
        <body className={inter.className}>{children}</body>
      </AuthSession>
    </html>
  );
}
