'use client'

import { Dispatch, SetStateAction, useState } from 'react'
import { ImCross } from 'react-icons/im'

interface Props {
  modalMessage: string | undefined
  setModalMessage: Dispatch<SetStateAction<string | undefined>>
  title: string
}

export default function Modal(props: Props) {
  if (!props.modalMessage) return
  return (
    <div className="flex justify-center fixed top-0 left-0 right-0 z-50 w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full">
      <div className="relative w-full max-w-2xl max-h-full mt-10">
        <div className="relative bg-white rounded-lg shadow dark:bg-gray-700">
          <div className="flex items-start justify-between p-4 border-b rounded-t dark:border-gray-600">
            <h3 className="text-xl font-semibold text-gray-900 dark:text-white">
              {props.title}
            </h3>
            <button
              onClick={() => {
                props.setModalMessage(undefined)
              }}
              type="button"
              className="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
            >
              <ImCross />
            </button>
          </div>
          <div className="p-6 space-y-6">{props.modalMessage}</div>
        </div>
      </div>
    </div>
  )
}
