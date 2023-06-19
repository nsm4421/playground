import './globals.css'
import { Nanum_Gothic } from 'next/font/google'
import RecoilProvider from '@/components/provider/recoil-provider'
import { ReactNode } from 'react'
import { Session } from 'next-auth'
import SessionProvider from '@/components/provider/session-provider'

// header
export const metadata = {
  title: 'Reivew App',
  description: 'Resturant Review',
}

// font
const nanum_gothic = Nanum_Gothic({ weight: '400', subsets: ['latin'] })

export default function RootLayout(props: {
  children: ReactNode
  session: Session
}) {
  return (
    <html lang="ko-KR" className="h-full dark:bg-gray-900 dark:text-white">
      <body className={nanum_gothic.className}>
        <RecoilProvider>
          <SessionProvider session={props.session}>
            {props.children}
          </SessionProvider>
        </RecoilProvider>
      </body>
    </html>
  )
}
