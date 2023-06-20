import { MouseEventHandler, ReactNode } from 'react'

interface Props {
  className?: string
  disabled?: boolean
  icon: ReactNode
  label: string
  onClick?: MouseEventHandler<HTMLButtonElement>
}

export default function IconButton(props: Props) {
  return (
    <button
      onClick={props.onClick}
      disabled={props.disabled}
      className={
        props.className ??
        'disabled:cursor-not-allowed bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-4 rounded-lg inline-flex items-center'
      }
    >
      {props.icon}
      <span>{props.label}</span>
    </button>
  )
}
