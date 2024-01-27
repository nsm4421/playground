import "./globals.css";
import { Inter } from "next/font/google";
import AuthSession from "@/components/auth-session";
import CustomNavbar from "@/app/nav-bar";

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
        <body className={inter.className + ' bg-slate-100 text dark:bg-slate-800 text-black dark:text-white'}>
          <CustomNavbar />
          {children}
        </body>
      </AuthSession>
    </html>
  );
}
