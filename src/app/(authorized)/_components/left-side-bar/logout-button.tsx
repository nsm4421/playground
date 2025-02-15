"use client";

interface Props {
  label?: string;
}

export default function LogoutButton({ label }: Props) {
  // TODO : 로그아웃 처리
  const handleLogout = () => {};

  return (
    <div onClick={handleLogout} className="group cursor-pointer flex gap-x-1">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        fill="none"
        viewBox="0 0 24 24"
        strokeWidth="1.5"
        stroke="currentColor"
        className="w-6"
      >
        <path
          className="group-hover:text-sky-600"
          strokeLinecap="round"
          strokeLinejoin="round"
          d="M15.75 9V5.25A2.25 2.25 0 0 0 13.5 3h-6a2.25 2.25 0 0 0-2.25 2.25v13.5A2.25 2.25 0 0 0 7.5 21h6a2.25 2.25 0 0 0 2.25-2.25V15M12 9l-3 3m0 0 3 3m-3-3h12.75"
        />
      </svg>
      {label && (
        <label className="text-md cursor-pointer group-hover:text-sky-600 group-hover:font-bold">
          {label}
        </label>
      )}
    </div>
  );
}
