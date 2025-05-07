import Image from 'next/image'
import Carousel from 'nuka-carousel/lib/carousel'
import { useState } from 'react'

const images = [
  {
    original: 'https://picsum.photos/id/1000/1000/600/',
    thumbnail: 'https://picsum.photos/id/1000/150/150/',
  },
  {
    original: 'https://picsum.photos/id/1001/1000/600/',
    thumbnail: 'https://picsum.photos/id/1001/150/150/',
  },
  {
    original: 'https://picsum.photos/id/1002/1000/600/',
    thumbnail: 'https://picsum.photos/id/1002/150/150/',
  },
]

export default function MyCarousel() {

  const [slideIndex, setSlideIndex] = useState<number>(0)
  const handleSlideIndex = (idx: number) => () => setSlideIndex(idx)

  return (
    <>
      {/* Carousel */}
      <Carousel
        animation="zoom"
        autoplay
        withoutControls
        speed={10}
        slideIndex={slideIndex}
      >
        {images.map((item) => (
          <Image
            key={item.original}
            src={item.original}
            width={1000}
            height={600}
            alt="big-image"
            layout="reponsive"
          />
        ))}
      </Carousel>

      {/* Thumbnails */}
      <div style={{ display: 'flex' }}>
        {images.map((item, idx) => (
          <div key={idx}>
            <Image
              src={item.thumbnail}
              alt="small-image"
              width={100}
              height={60}
              onClick={handleSlideIndex(idx)}
            />
          </div>
        ))}
        <div/>
       
      </div>
    </>
  )
}
