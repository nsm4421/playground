"use client";

import ButtonAtom from "@/components/atom/button-atom";
import InputAtom from "@/components/atom/input-atom";
import useInput from "@/util/hook/use-input";
import { XMarkIcon } from "@heroicons/react/24/solid";
import axios from "axios";
import { useEffect, useState } from "react";

export default function SetNickname() {
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const { value: nickname, setValue: setNickname, onChange } = useInput("");
  const [message, setMessage] = useState<string | null>(null);

  const clearMessage = () => setMessage(null);

  const setInitNickname = async () => {
    setIsLoading(true);
    await axios
      .get("/api/auth/setting/nickname")
      .then((res) => res.data.data)
      .then((nickname) => {
        if (nickname) setNickname(nickname)       
        else setMessage("You haven't set nickname")
      })
      .finally(() => setIsLoading(false));
  };

  // handle submit nickname
  const handleSubmit = async () => {
    if (!nickname) {
      setMessage("nickname is not given");
      return;
    }
    setIsLoading(true);
    axios
      .post("/api/auth/setting/nickname", { nickname })
      .then((res) => res.data)
      .then((data) => {
        console.log(data)
        setNickname(data.nickname);
      })
      .finally(() => setIsLoading(false));
  };

  useEffect(() => {
    setInitNickname();
  }, []);

  return (
    <>
      <p className="px-4 text-lg font-extrabold">Nickname</p>
      <div className="px-4 py-4 flex justify-between gap-3">
        <div className="flex-grow">
          <InputAtom value={nickname} onChange={onChange} placeholder="your nickname" />
        </div>
        <div>
          <ButtonAtom
            disabled={isLoading}
            label={"Edit"}
            onClick={handleSubmit}
          />
        </div>
      </div>
      {message && (
        <div className="px-6 justify-between">
          <span className="text-red-400 text-sm">{message}</span>
          <XMarkIcon
            onClick={clearMessage}
            className="w-6 h-6 float-right hover:text-red-400"
          />
        </div>
      )}
    </>
  );
}
