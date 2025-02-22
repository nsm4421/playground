"use client";

import LogoutIcon from "@/components/icon/logout-icon";

interface Props {
  label?: string;
}

export default function LogoutButton({ label }: Props) {
  // TODO : 로그아웃 처리
  const handleLogout = () => {};

  return (
    <div onClick={handleLogout} className="group cursor-pointer flex gap-x-1">
      <LogoutIcon clsName="group-hover:text-sky-600" />

      {label && (
        <label className="text-md cursor-pointer group-hover:text-sky-600 group-hover:font-bold">
          {label}
        </label>
      )}
    </div>
  );
}
