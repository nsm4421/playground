"use client";

import { useRouter } from "next/navigation";
import { ChangeEvent, useEffect, useState } from "react";

export default function SetNickname() {
  const router = useRouter();
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [nickname, setNickname] = useState<string | null>(null);
  const handleNickname = (e: ChangeEvent<HTMLInputElement>) => {
    setNickname(e.target.value);
  };

  // on mounted, get nickname from DB
  const setInitNickname = async () => {
    setIsLoading(true);
    await fetch("/api/auth/setting/nickname")
      .then((res) => res.json())
      .then((data) => {
        if (data.success) return setNickname(data.data);
      });
    setIsLoading(false);
  };

  useEffect(() => {
    setInitNickname();
  }, []);

  // handle submit nickname
  const handleSubmit = async () => {
    setIsLoading(true);
    // check nickname
    if (!nickname) {
      alert("nickname is not given");
      return;
    }
    // save nickname
    await fetch("/api/auth/setting/nickname", {
      method: "POST",
      body: JSON.stringify({ nickname }),
    })
      .then((res) => res.json())
      .then((data) => {
        if (data.success) {
          router.push("/");
          return;
        }
        alert(data.message);
      })
      .catch(console.error)
      .finally(() => setIsLoading(false));
  };

  return (
    <>
      <label>Set Username</label>
      <br/>
      <input value={nickname ?? ""} onChange={handleNickname} />
      <button disabled={isLoading} onClick={handleSubmit}>
        Submit
      </button>
    </>
  );
}
