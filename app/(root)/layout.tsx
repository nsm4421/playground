import { ClerkProvider } from "@clerk/nextjs";
import "../globals.css";
import type { Metadata } from "next";
import { Inter } from "next/font/google";
import NavBarComponent from "@/components/nav-bar";
import AppShellComponent from "@/components/app-shell";
import BottomNavComponent from "@/components/bottom-nav";
import RightSidebarComponent from "@/components/right-sidebar";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "Karma",
  description: "My SNS App",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <ClerkProvider>
      <html lang="en">
        <body className={`${inter.className} bg-slate-700 text-white`}>
          <NavBarComponent />
          <main className="flex flex-row">
            <AppShellComponent />
            <section className="main-container">{children}</section>
            <RightSidebarComponent />
          </main>
          <BottomNavComponent />
        </body>
      </html>
    </ClerkProvider>
  );
}
