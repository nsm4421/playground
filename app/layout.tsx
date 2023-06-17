import './globals.css'
import { Inter, Nanum_Gothic } from 'next/font/google'
import RecoilProvider from '@/components/provider/recoil-provider'

// header
export const metadata = {
  title: 'Reivew App',
  description: 'Resturant Review',
}

// font
const nanum_gothic = Nanum_Gothic({ weight: '400', subsets: ['latin'] })

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="ko-KR" className="h-full dark:bg-gray-900 dark:text-white">
      <body className={nanum_gothic.className}>
        <RecoilProvider>{children}</RecoilProvider>
      </body>
    </html>
  )
}
