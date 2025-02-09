"use client";

import { useState } from "react";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { useRouter } from "next/navigation";
import { RoutePaths } from "@/constant/route";
import ClearIconButton from "@/components/icon/clear-button";

export default function SignUpModal() {
  const [id, setId] = useState<string>("");
  const [password, setPassword] = useState<string>("");
  const [nickname, setNickanme] = useState<string>("");
  const [file, setFile] = useState<File | undefined>(undefined);
  const [message, setMessage] = useState<string>("");

  const router = useRouter();

  const handleClose = () => router.replace(RoutePaths.entry);

  // TODO
  const handleSubmit = () => {};

  return (
    <div className="fixed inset-0 bg-black bg-opacity-30 flex items-center justify-center z-50">
      <div className="bg-white rounded-2xl shadow-xl max-w-md w-full p-6 relative">
        <header className="flex justify-between items-center mb-3">
          <h2 className="text-xl font-semibold text-gray-800 mb-3">Sign Up</h2>
          <ClearIconButton onClick={handleClose} />
        </header>

        <form className="mb-5">
          <ul className="flex flex-col gap-y-3">
            <li className="flex items-center gap-x-3">
              <label htmlFor="id" className="text-sm text-slate-700">
                <svg
                  className="w-5"
                  fill="none"
                  strokeWidth={1.5}
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                  xmlns="http://www.w3.org/2000/svg"
                  aria-hidden="true"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    d="M15 9h3.75M15 12h3.75M15 15h3.75M4.5 19.5h15a2.25 2.25 0 0 0 2.25-2.25V6.75A2.25 2.25 0 0 0 19.5 4.5h-15a2.25 2.25 0 0 0-2.25 2.25v10.5A2.25 2.25 0 0 0 4.5 19.5Zm6-10.125a1.875 1.875 0 1 1-3.75 0 1.875 1.875 0 0 1 3.75 0Zm1.294 6.336a6.721 6.721 0 0 1-3.17.789 6.721 6.721 0 0 1-3.168-.789 3.376 3.376 0 0 1 6.338 0Z"
                  />
                </svg>
              </label>
              <Input
                id="id"
                value={id}
                onChange={(e) => setId(e.target.value)}
                placeholder="id"
              />
            </li>
            <li className="flex items-center gap-x-3">
              <label htmlFor="password" className="text-sm text-slate-700">
                <svg
                  className="w-5"
                  fill="none"
                  strokeWidth={1.5}
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                  xmlns="http://www.w3.org/2000/svg"
                  aria-hidden="true"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    d="M15.75 5.25a3 3 0 0 1 3 3m3 0a6 6 0 0 1-7.029 5.912c-.563-.097-1.159.026-1.563.43L10.5 17.25H8.25v2.25H6v2.25H2.25v-2.818c0-.597.237-1.17.659-1.591l6.499-6.499c.404-.404.527-1 .43-1.563A6 6 0 1 1 21.75 8.25Z"
                  />
                </svg>
              </label>
              <Input
                id="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="password"
                type="password"
              />
            </li>
            <li className="flex items-center gap-x-3">
              <label htmlFor="nickname" className="text-sm text-slate-700">
                <svg
                  className="w-5"
                  fill="none"
                  strokeWidth={1.5}
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                  xmlns="http://www.w3.org/2000/svg"
                  aria-hidden="true"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    d="M17.982 18.725A7.488 7.488 0 0 0 12 15.75a7.488 7.488 0 0 0-5.982 2.975m11.963 0a9 9 0 1 0-11.963 0m11.963 0A8.966 8.966 0 0 1 12 21a8.966 8.966 0 0 1-5.982-2.275M15 9.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"
                  />
                </svg>
              </label>
              <Input
                id="nickname"
                value={nickname}
                onChange={(e) => setNickanme(e.target.value)}
                placeholder="nickname"
              />
            </li>
          </ul>
          <div>{message}</div>
        </form>

        <div className="flex gap-x-3 justify-end">
          <Button onClick={handleSubmit}>Submit</Button>
        </div>
      </div>
    </div>
  );
}
