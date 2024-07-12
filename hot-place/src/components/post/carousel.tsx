import Image from 'next/image';
import Slider from 'react-slick';

interface CarouselProps {
    imageUrls: string[],
    width: number,
    height: number
}

export default function Carousel({
    imageUrls,
    width = 800,
    height = 500
}: CarouselProps) {

    const settings = {
        dots: true,
        infinite: true,
        speed: 500,
        slidesToScroll: 1,
        slidesToShow: 1,
    }

    return (
        <div>
            <Slider {...settings}>
                {imageUrls.map((imageUrl, index) => (
                    <div key={index}>
                        <Image src={imageUrl} alt={`${index} th image`} width={width} height={height} />
                    </div>
                ))}
            </Slider>
        </div>
    );
};

