"use client";

import { ChangeEvent, useEffect, useState } from "react";

interface Props {
  src?: string;
}

export default function usePreview({ src }: Props) {
  const [initialized, setInitialized] = useState<boolean>(false);
  const [currentImage, setCurrentImage] = useState<File | null>(null);
  const [preview, setPreview] = useState<string | null>(null);

  const _init = async (src: string) => {
    try {
      setInitialized(true);
      await fetch(src)
        .then((res) => {
          if (!res.ok) {
            throw new Error("Network response was not ok");
          }
          return res.blob();
        })
        .then(
          (blob) => new File([blob], "current-image-file", { type: blob.type })
        )
        .then((file) => setCurrentImage(file));
    } catch (error) {
      console.error(error);
    } finally {
      setInitialized(false);
    }
  };

  const handleSelect = (e: ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (!files) return;
    setCurrentImage(files[0]);
  };

  const handleUnSelect = () => setCurrentImage(null);

  useEffect(() => {
    src && _init(src);
  }, []);

  useEffect(() => {
    if (currentImage) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setPreview(reader.result as string);
      };
      reader.readAsDataURL(currentImage);
    } else {
      setPreview(null);
    }
  }, [currentImage]);

  return {
    initialized,
    currentImage,
    preview,
    handleSelect,
    handleUnSelect
  };
}
