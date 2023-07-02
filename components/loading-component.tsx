import { AiOutlineLoading } from 'react-icons/ai'

interface Props {
  className?: string
}

export default function Loading(props: Props) {
  const clsName =
    'flex opacity-50 justify-center items-center bg-gray-200 dark:bg-gray-600' +
    +' ' +
    (props.className && props.className)
  return (
    <div className={clsName}>
      <AiOutlineLoading
        className="animate-spin text-blue-400 dark:text-blue-500"
        size={200}
      />
    </div>
  )
}
