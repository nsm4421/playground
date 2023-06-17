import { useState } from 'react'

interface Props {
  label: string
  onClick: Function
  type?: 'BLUE_ROUND' | 'GREEN_ROUND'
}

export default function Button(props: Props) {
  let clsName: string =
    'text-white bg-blue-700 hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 font-medium rounded-full text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800'
  switch (props.type) {
    case 'GREEN_ROUND':
      clsName =
        'text-white bg-gradient-to-r from-green-400 via-green-500 to-green-600 hover:bg-gradient-to-br focus:ring-4 focus:outline-none focus:ring-green-300 dark:focus:ring-green-800 font-medium rounded-full text-sm px-5 py-2.5 text-center'
      break
    case 'BLUE_ROUND':
      clsName =
        'text-white bg-gradient-to-r from-blue-500 via-blue-600 to-blue-700 hover:bg-gradient-to-br focus:ring-4 focus:outline-none focus:ring-blue-300 dark:focus:ring-blue-800 font-medium rounded-full text-sm px-5 py-2.5 text-center'
      break
  }

  const [isLoading, setIsLoading] = useState<boolean>(false)
  const handleClick = async () => {
    setIsLoading(true)
    await props.onClick()
    setIsLoading(false)
  }
  return (
    <button
      type="button"
      disabled={isLoading}
      onClick={handleClick}
      className={clsName}
    >
      <span className="font-bold">{props.label}</span>
    </button>
  )
}
