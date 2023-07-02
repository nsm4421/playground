'use client'

import { Dispatch, SetStateAction } from 'react'

interface Props {
  labels: string[]
  selected: number
  isLoading?: boolean
  setSelected: Dispatch<SetStateAction<number>>
}

export default function CateoryTab(props: Props) {
  const clsNameActive =
    'cursor-pointer inline-block p-2 border-b-2 rounded-t-lg hover:bg-slate-500 ml-2 text-white bg-slate-500 font-bold'
  const clsNameDeActive =
    'cursor-pointer inline-block p-2 border-b-2 rounded-t-lg hover:bg-slate-500 ml-2 bg-slate-200 dark:bg-slate-800 font-extralight'
  const handleOnClick = (idx: number) => () => {
    props.setSelected(idx)
  }
  return (
    <div className="w-full">
      <nav className="max-w-fit">
        <ul className="flex">
          {props.labels.map((label, idx) => (
            <li key={idx}>
              <button
                disabled={props.isLoading}
                className={
                  idx === props.selected ? clsNameActive : clsNameDeActive
                }
                onClick={handleOnClick(idx)}
              >
                {label}
              </button>
            </li>
          ))}
        </ul>
      </nav>
    </div>
  )
}
