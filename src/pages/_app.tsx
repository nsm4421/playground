import Navbar from "@/components/nav/navbar";
import "@/styles/globals.css";
import { SessionProvider } from "next-auth/react";
import type { AppProps } from "next/app";
import { RecoilRoot } from "recoil";

export default function App({ Component, pageProps }: AppProps) {
  const { session } = pageProps
  return <SessionProvider session={session}>
    <RecoilRoot>
      <Navbar />
      <Component {...pageProps} />
    </RecoilRoot>
  </SessionProvider>
}
