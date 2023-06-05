"use client";

import { RegisterRequest } from "@/util/model";
import { useRouter } from "next/navigation";
import { ChangeEvent, useState } from "react";

export default function RegisterForm() {
  const router = useRouter();
  const [input, setInput] = useState<RegisterRequest>({
    email: "",
    password: "",
  });
  const [isLoading, setIsLoading] = useState(false);

  const handleInput = (field: string) => (e: ChangeEvent<HTMLInputElement>) => {
    setInput({ ...input, [field]: e.target.value });
  };

  const handleSubmit = async () => {
    try {
      setIsLoading(true);
      await fetch("/api/auth/register", {
        method: "POST",
        body: JSON.stringify(input),
      })
        .then((res) => res.json())
        .then((data) => {
          if (data.success) {
            router.push("/");
            return;
          }
          alert(data.message);
        });
    } catch (err) {
      console.error(err);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <>
      <div>
        <label>Email</label>
        <input
          value={input.email}
          onChange={handleInput("email")}
          placeholder="example@naver.com"
        />
      </div>
      <div>
        <label>Password</label>
        <input
          type="password"
          value={input.password}
          onChange={handleInput("password")}
          placeholder="1q2w3e4r!"
        />
      </div>
      <button disabled={isLoading} type="submit" onClick={handleSubmit}>
        Register
      </button>
    </>
  );
}
