import {
  ChangeEvent,
  Dispatch,
  FocusEventHandler,
  PointerEventHandler,
  SetStateAction,
} from 'react'

interface Props {
  content: string
  setContent: Dispatch<SetStateAction<string>>
  type?: string
  placeholder?: string
  maxCharactor?: number
  onFocus?: FocusEventHandler<HTMLInputElement>
  onPointerLeave?: PointerEventHandler<HTMLInputElement>
}

export default function Input(props: Props) {
  const handleContent = (e: ChangeEvent<HTMLInputElement>) => {
    let v = e.target.value
    props.setContent(props.maxCharactor ? v.slice(0, props.maxCharactor) : v)
  }
  return (
    <input
      onFocus={props.onFocus ?? undefined}
      onPointerLeave={props.onPointerLeave ?? undefined}
      type={props.type ?? 'text'}
      value={props.content}
      onChange={handleContent}
      placeholder={props.placeholder}
      className="tracking-wider resize-none block p-2.5 w-full font-bold text-md text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
    />
  )
}
