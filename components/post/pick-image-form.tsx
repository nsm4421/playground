import { faImage, faPlus, faXmark } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Dispatch, SetStateAction, useEffect, useRef, useState } from "react";
import { toast } from "react-toastify";
import { Image } from "@nextui-org/react";

interface Props {
  imageFiles: File[];
  setImageFiles: Dispatch<SetStateAction<File[]>>;
  maxNumber: number;
  maxSize?: number;
}

export default function PickImageForm(props: Props) {
  const maxSize = 5 * 1024 * 1024; // 5MB
  const ref = useRef<HTMLInputElement | null>(null);
  const [imageUrls, setImageUrls] = useState<string[]>([]);

  useEffect(() => {
    const urls = props.imageFiles.map((file) => URL.createObjectURL(file));
    setImageUrls(urls);
  }, [props.imageFiles]);

  const handleAddPicuture = () => {
    if (ref.current) {
      ref.current.click();
    }
  };

  const handleCancelPicture = (index: number) => () => {
    let imageFiles = [...props.imageFiles];
    imageFiles.splice(index, 1);
    props.setImageFiles(imageFiles);
  };

  const handleSelect = async (e: React.ChangeEvent<HTMLInputElement>) => {
    // 선택한 파일 개수 체크
    const files = Array.from(e.target.files ?? []);
    if (files.length + props.imageFiles.length > props.maxNumber) {
      toast.warn(`Image can be picked up to ${props.maxNumber}`);
      return;
    }
    // 파일 사이즈 체크
    for (var f of files) {
      if (f.size > maxSize) {
        toast.warn(`Maximum size is ${Math.floor(maxSize / 1024 / 1024)}MB`);
        return;
      }
    }
    // 이미지 상태 업데이트
    props.setImageFiles([...props.imageFiles, ...files]);
  };

  return (
    <div>
      {/* 헤더 */}
      <div className="flex justify-between items-center">
        <div className="flex justify-start items-center">
          <h1 className="text-lg font-bold">Pictures</h1>
          <span className="text-slate-500 mx-2 text-sm">
            {props.imageFiles.length}/{props.maxNumber}
          </span>
        </div>

        {/* 이미지 추가하기 버튼 */}
        <button
          onClick={handleAddPicuture}
          className="relative w-12 h-12 rounded-full hover:bg-orange-500"
        >
          <FontAwesomeIcon
            icon={faImage}
            className="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-5 h-5"
          />
          <FontAwesomeIcon
            icon={faPlus}
            className="absolute top-1 right-1 w-3 h-3"
          />
        </button>
      </div>

      {/* 숨겨진 이미지 선택창 */}
      <input
        multiple={true}
        type="file"
        ref={ref}
        hidden
        onChange={handleSelect}
      />

      {/* 이미지 미리보기 */}
      <ul className="flex w-full justify-start item-center mt-3">
        {imageUrls &&
          imageUrls.map((url, index) => (
            <li
              key={index}
              className="relative"
              onClick={handleCancelPicture(index)}
            >
              <i className="flex top-0 right-0 absolute hover:text-rose-500">
                <FontAwesomeIcon icon={faXmark} />
              </i>
              <Image
                isZoomed
                height={250}
                width={250}
                loading="lazy"
                className="w-20 h-20 rounded-full mx-3"
                removeWrapper
                alt={`selected-${index}th-image`}
                src={url}
              />
            </li>
          ))}
      </ul>
    </div>
  );
}
