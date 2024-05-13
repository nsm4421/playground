import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
import ClerkProviderWrapper from "@/lib/provider/clerk-provider";

const font = Inter({ subsets: ["latin"] });

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
        <body className={font.className}>{props.children}</body>
      </ClerkProviderWrapper>
    </html>
  );
}
