'use client'

import Image from 'next/image'
import { AiOutlineLeft, AiOutlineRight } from 'react-icons/ai'
import { useEffect, useState } from 'react'
import axios from 'axios'

interface Props {
  images: string[]
  width?: number
  height?: number
}

export default function Carousel(props: Props) {
  const [selected, setSelected] = useState<number>(0)
  const [imagesData, setImagesData] = useState<string[]>([])
  const handleGoPrevious = () =>
    setSelected((selected - 1 + props.images.length) % props.images.length)
  const handleGoNext = () => setSelected((selected + 1) % props.images.length)
  // idx번째 이미지를 가져오기
  const setImage = async (idx: number) => {
    const data = await axios
      .get(`/api/s3?key=${props.images[idx]}`)
      .then((res) => res.data.data)
    if (!data) return
    const newUrls = [...imagesData]
    newUrls[idx] = `data:image/jpeg;base64,${data}`
    setImagesData(newUrls)
  }
  useEffect(() => {
    // 이미지 테이터가 fetch되지 않은 경우
    if (!imagesData[selected]) setImage(selected)
  }, [selected])
  return (
    <div className="relative w-full" data-carousel="static">
      <div className="relative h-56 overflow-hidden rounded-lg md:h-96">
        {imagesData.map(
          (url, idx) =>
            url.startsWith('data:image/') && (
              <div
                key={idx}
                className={`${
                  idx !== selected ? 'hidden' : ''
                } duration-700 ease-in-out block`}
                data-carousel-item
              >
                <Image
                  width={props.width ?? 50}
                  height={props.height ?? 50}
                  src={url}
                  className="absolute max-w-fit max-h-full h-full block w-full -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2"
                  alt={idx.toString()}
                />
              </div>
            )
        )}

        {/* 뒤로가기 버튼 */}
        <button
          onClick={handleGoPrevious}
          type="button"
          className="absolute top-0 left-0 z-30 flex items-center justify-center h-full px-4 cursor-pointer group focus:outline-none"
        >
          <span className="inline-flex items-center justify-center w-10 h-10 rounded-full bg-white/30 dark:bg-gray-800/30 group-hover:bg-white/50 dark:group-hover:bg-gray-800/60 group-focus:ring-4 group-focus:ring-white dark:group-focus:ring-gray-800/70 group-focus:outline-none">
            <AiOutlineLeft className="text-2xl font-extrabold" />
          </span>
        </button>

        {/* 앞으로 가기 버튼 */}
        <button
          onClick={handleGoNext}
          type="button"
          className="absolute top-0 right-0 z-30 flex items-center justify-center h-full px-4 cursor-pointer group focus:outline-none"
        >
          <span className="inline-flex items-center justify-center w-10 h-10 rounded-full bg-white/30 dark:bg-gray-800/30 group-hover:bg-white/50 dark:group-hover:bg-gray-800/60 group-focus:ring-4 group-focus:ring-white dark:group-focus:ring-gray-800/70 group-focus:outline-none">
            <AiOutlineRight className="text-2xl font-extrabold" />
          </span>
        </button>
      </div>
    </div>
  )
}
