import './globals.css'
import { Nanum_Gothic } from 'next/font/google'
import { ReactNode } from 'react'
import { Session } from 'next-auth'
import SessionProvider from '@/components/provider/session-provider'
import Nav from '@/components/atom/nav-component'

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
        <SessionProvider session={props.session}>
          <Nav />
          {props.children}
        </SessionProvider>
      </body>
    </html>
  )
}
