import {
  ChangeEvent,
  Dispatch,
  MouseEventHandler,
  SetStateAction,
  useState,
} from 'react'

interface Props {
  label: string
  items: string[]
  selected: number
  setSelected: Dispatch<SetStateAction<number>>
}

export default function DropDownSlider(props: Props) {
  const handleSelected = (idx: number) => () => {
    console.log(idx)
    props.setSelected(idx)
  }
  const clsNameActvie =
    'm-1 bg-slate-500 text-white rounded-md p-1 text-center hover:bg-slate-500'
  const clsNameDeActvie = 'm-1 p-1 text-center hover:bg-orange-500'
  return (
    <ul className="flex min-w-fit">
      {props.items.map((item, idx) => (
        <li
          key={idx}
          onClick={handleSelected(idx)}
          className={idx === props.selected ? clsNameActvie : clsNameDeActvie}
        >
          {item}
        </li>
      ))}
    </ul>
  )
}
