"use client";

import { ChangeEvent, useRef, useState } from "react";
import Image from "next/image";
import { AiOutlineClose } from "react-icons/ai";
import { Button } from "@/components/ui/button";
import useAuth from "@/lib/provider/use-auth";
import usePreview from "@/lib/hooks/use-preview";
import { Input } from "@/components/ui/input";
import editProfileAction from "@/lib/action/edit-profile";
import { toast } from "react-toastify";
import { useRouter } from "next/navigation";

export default function SelectImageForm() {
  const router = useRouter()
  const ref = useRef<HTMLInputElement>(null);
  const { user } = useAuth();
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [nickname, setNickname] = useState<string>(
    user?.app_metadata.nickanme ?? ""
  );
  const {
    currentImage: profileImage,
    handleSelect,
    handleUnSelect,
    preview,
  } = usePreview({
    src: user?.user_metadata.profile_image ?? undefined,
  });

  const handleNickname = (e: ChangeEvent<HTMLInputElement>) =>
    setNickname(e.target.value);

  const handleClickInputTag = () => {
    if (ref.current) {
      ref.current.click();
    }
  };

  const handleSubmit = async () => {
    try {
      if (!nickname || !profileImage) {
        toast.warn("check nickname or profile image is empty", {
          position: "top-center",
        });
        return;
      }
      setIsLoading(true);
      editProfileAction({ nickname, profileImage });
      router.push("/")
      toast.success("profile is updated", {
        position: "top-center",
      });
    } catch (error) {
      console.error(error);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <section>
      <div>
        <button
          className="text-lg font-semibold hover:text-orange-500"
          onClick={handleClickInputTag}
        >
          Select Your Proile Image
        </button>
        <input
          ref={ref}
          id="select-profile-button"
          hidden
          type="file"
          accept="image/*"
          onChange={handleSelect}
        />
      </div>

      {/* 미리보기 */}
      <figure className="flex mx-auto my-5">
        {preview && (
          <div className="relative w-48 h-48">
            <Image
              className="rounded-full overflow-hidden"
              src={preview}
              alt="profile-preview"
              layout="fill"
              objectFit="cover"
            />
            <AiOutlineClose
              onClick={handleUnSelect}
              className="absolute top-2 right-2 w-6 h-6 bg-slate-500 text-white rounded-full flex items-center justify-center"
            />
          </div>
        )}
      </figure>

      {/* 닉네임 */}
      <div className="my-5">
        <Input
          placeholder="nickname"
          value={nickname}
          onChange={handleNickname}
        />
      </div>

      {/* 제출버튼 */}
      <div className="my-5">
        <Button disabled={isLoading} onClick={handleSubmit}>
          Submit
        </Button>
      </div>
    </section>
  );
}
