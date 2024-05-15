import type { Metadata } from "next";
import { Nanum_Pen_Script } from "next/font/google";
import "./globals.css";
import ClerkProviderWrapper from "@/lib/provider/clerk-provider";
import TopNavbar from "@/components/top-navbar";
import { NextUiProviderWrapper } from "@/lib/provider/next-ui-provider";
import { ToastContainer } from "react-toastify";
import 'react-toastify/dist/ReactToastify.css'

const nanum_pen_script = Nanum_Pen_Script({
  subsets: ["latin"],
  weight: "400",
});

export const metadata: Metadata = {
  title: "Traveler",
  description: "여행 어플",
};

interface Props {
  children: React.ReactNode;
}

export default function RootLayout(props: Props) {
  return (
    <html lang="en">
      <ClerkProviderWrapper>
        <body
          className={`${nanum_pen_script.className} h-screen max-w-3xl mx-auto`}
        >
          <NextUiProviderWrapper>
            <TopNavbar />
            {props.children}
          </NextUiProviderWrapper>
          <ToastContainer position="top-center"/>
        </body>
      </ClerkProviderWrapper>
    </html>
  );
}
