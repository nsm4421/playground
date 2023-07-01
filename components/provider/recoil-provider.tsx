'use client'

import { ReactNode } from 'react'
import { RecoilRoot } from 'recoil'

type Props = {
  children: ReactNode
  override?: boolean
}

export default function RecoilProvider(props: Props) {
  return (
    <RecoilRoot override={props.override ?? true}>{props.children}</RecoilRoot>
  )
}
