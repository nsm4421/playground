'use client'

import { Session } from 'next-auth'
import { signOut, useSession } from 'next-auth/react'
import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { useState } from 'react'
import { MdExpandLess, MdExpandMore } from 'react-icons/md'

const navItems = {
  login: [
    { label: '음식점', href: '/restaurant' },
    { label: '로그아웃', href: '/auth/sign-in', onClick: () => signOut() },
  ],
  notLogin: [
    { label: '회원가입', href: '/auth/sign-up' },
    { label: '로그인', href: '/auth/sign-in' },
  ],
}

export default function Nav() {
  const [expand, setExpand] = useState<boolean>(false)
  const { data: session } = useSession()

  const handleExpand = () => setExpand(!expand)

  return (
    <nav className="bg-white border-gray-200 dark:bg-gray-900">
      <div className="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
        <Link href="/">
          <span className="self-center text-2xl font-semibold whitespace-nowrap dark:text-white hover:text-orange-400">
            Karma
          </span>
        </Link>

        <div className="flex justify-start align-middle">
          <div className="flex max-[768px]:hidden">
            <NavItmes session={session} />
          </div>
          {/* Button */}
          <button onClick={handleExpand} className="md:hidden md:w-auto">
            {expand ? (
              <MdExpandLess className="text-2xl" />
            ) : (
              <MdExpandMore className="text-2xl" />
            )}
          </button>
        </div>

        {/* Button */}
        {expand && (
          <div className={'w-full md:block md:w-auto'}>
            <ul className="font-medium flex flex-col p-4 md:p-0 mt-4 border border-gray-100 rounded-lg bg-gray-50 md:flex-row md:space-x-8 md:mt-0 md:border-0 md:bg-white dark:bg-gray-800 md:dark:bg-gray-900 dark:border-gray-700">
              <NavItmes session={session} />
            </ul>
          </div>
        )}
      </div>
    </nav>
  )
}

function NavItmes(props: { session: Session | null }) {
  const pathname = usePathname()
  return (props.session ? navItems.login : navItems.notLogin).map(
    (item, idx) => (
      <NavItem {...item} key={idx} selected={item.href == pathname} />
    )
  )
}

function NavItem(props: {
  label: string
  href?: string
  selected?: boolean
  onClick?: Function
}) {
  const el = (
    <li
      onClick={() => {
        props.onClick && props.onClick()
      }}
      className={`${
        props.selected
          ? 'font-extrabold text-black dark:text-white'
          : 'text-gray-600 dark:text-slate-400'
      } w-15 px-2 mx-2 dark:border-slate-700 text-center p-2 mb-2 block hover:bg-orange-200 hover:dark:bg-slate-500`}
    >
      <span>{props.label}</span>
    </li>
  )

  if (props.href) return <Link href={props.href}>{el}</Link>
  return el
}
