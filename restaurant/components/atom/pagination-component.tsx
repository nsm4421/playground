import { Dispatch, SetStateAction } from 'react'
import { AiOutlineArrowRight, AiOutlineArrowLeft } from 'react-icons/ai'
import { IconType } from 'react-icons/lib'

interface Props {
  page: number
  setPage: Dispatch<SetStateAction<number>>
  totalCount: number
  label?: string | IconType
}

export default function Pagination(props: Props) {
  const min = Math.max(1, props.page - 5)
  const max = Math.min(Math.ceil(props.totalCount / 10), props.page + 5)
  const clsNameActive =
    'mx-3 p-2 bg-blue-300 dark:bg-blue-800 text-slate-800 border border-blue-300 bg-blue-50 hover:bg-blue-100 hover:text-blue-700 dark:border-gray-700 dark:bg-gray-700 dark:text-white'
  const clsNameDeActive =
    'mx-3 p-2 text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white'
  const handlePage = (page: number) => () => {
    props.setPage(page)
    console.log(page)
  }

  return (
    <nav className="flex justify-center">
      <ul className="flex items-center">
        {/* 이전 페이지 */}
        <div
          className={
            props.page === 1
              ? 'cursor-not-allowed ' + clsNameDeActive
              : clsNameActive
          }
        >
          <button
            className="text-center"
            onClick={handlePage(props.page - 1)}
            disabled={props.page === 1}
          >
            <AiOutlineArrowLeft />
          </button>
        </div>
        {/* 페이지 번호 */}
        <div className="flex justify-center">
          {Array.from({ length: max - min + 1 }, (_, idx) => idx + 1).map(
            (idx) => (
              <div
                key={idx}
                className={idx === props.page ? clsNameActive : clsNameDeActive}
              >
                <button
                  key={idx}
                  className="text-center"
                  onClick={handlePage(idx)}
                >
                  {idx}
                </button>
              </div>
            )
          )}
        </div>
        {/* 다음 페이지 */}
        <div
          className={
            props.page === Math.ceil(props.totalCount / 10)
              ? ' cursor-not-allowed ' + clsNameDeActive
              : clsNameActive
          }
        >
          <button
            onClick={handlePage(props.page + 1)}
            disabled={props.page === max}
            className="text-center"
          >
            <AiOutlineArrowRight />
          </button>
        </div>
      </ul>
    </nav>
  )
}
