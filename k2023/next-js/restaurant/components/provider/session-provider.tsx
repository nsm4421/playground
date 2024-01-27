'use client'

import { Session } from 'next-auth'
import { SessionProvider as Provider } from 'next-auth/react'
import { ReactNode } from 'react'

type Props = {
  session: Session
  children: ReactNode
}

export default function SessionProvider(props: Props) {
  return <Provider session={props.session}>{props.children}</Provider>
}
