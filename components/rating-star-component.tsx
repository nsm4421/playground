'use client'

import { Dispatch, SetStateAction } from 'react'
import { AiOutlineStar } from 'react-icons/ai'
import { AiFillStar } from 'react-icons/ai'

interface Props {
  min: number
  max: number
  rating: number
  size?: 'LG' | 'MD' | 'SM'
  setRating: Dispatch<SetStateAction<number>>
}

export default function StartRating(props: Props) {
  const handleRating = (idx: number) => () => props.setRating(idx)
  let sizeClsName: string = 'text-xl'
  switch (props.size) {
    case 'LG':
      sizeClsName = 'text-5xl'
      break
    case 'MD':
      sizeClsName = 'text-3xl'
      break
  }

  return (
    <div className="flex">
      {Array.from(
        { length: props.max - props.min + 1 },
        (_, idx) => props.min + idx
      ).map((idx) => (
        <div key={idx}>
          {idx <= props.rating ? (
            // selected
            <AiFillStar
              onClick={handleRating(idx)}
              className={`cursor-pointer text-yellow-500 ${sizeClsName}`}
            />
          ) : (
            // not selected
            <AiOutlineStar
              onClick={handleRating(idx)}
              className={`cursor-pointer text-gray-500 dark:text-gray-200 ${sizeClsName}`}
            />
          )}
        </div>
      ))}
    </div>
  )
}
