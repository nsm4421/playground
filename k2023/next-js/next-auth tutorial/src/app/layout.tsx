import NavBar from "@/components/nav-bar";
import Providers from "../components/Providers";
import "./globals.css";

export const metadata = {
  title: "Karma",
  description: "Next Auth Tutorial",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className="h-full">
      <Providers>
        <body className="h-full">
          <NavBar />
          {children}
        </body>
      </Providers>
    </html>
  );
}
