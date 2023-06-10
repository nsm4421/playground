"use client";

import { signIn, signOut, useSession } from "next-auth/react";
import Link from "next/link";
import { usePathname } from "next/navigation";

const NavItemComponent = (props: {
  label: string;
  path: string;
  onClick?: () => void;
}) => {
  const currentPath = usePathname();
  const clsName =
    "cursor-pointer block py-2 pl-3 pr-4 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent";
  const activeClsName =
    "cursor-pointer block py-2 pl-3 pr-4 text-white bg-blue-700 rounded md:bg-transparent md:text-blue-700 md:p-0 dark:text-white md:dark:text-blue-500";

  if (props.onClick) {
    return (
      <li>
        <div className={clsName} aria-current="page" onClick={props.onClick}>
          {props.label}
        </div>
      </li>
    );
  }

  return (
    <li>
      <Link href={props.path}>
        <div
          className={props.path === currentPath ? activeClsName : clsName}
          aria-current="page"
        >
          {props.label}
        </div>
      </Link>
    </li>
  );
};

const navItems = {
  notLogined: [
    {
      label: "Home",
      path: "/",
    },
    {
      label: "Register",
      path: "/auth/register",
    },
    {
      label: "Sign In",
      path: "/api/auth/signin",
      onClick: () => {
        signIn();
      },
    },
    {
      label: "Post",
      path: "/post",
    },
  ],
  logined: [
    {
      label: "Home",
      path: "/",
    },
    {
      label: "Post",
      path: "/post",
    },
    {
      label: "Sign Out",
      path: "/api/auth/signOut",
      onClick: () => {
        signOut();
      },
    },
  ],
};

export default function CustomNavbar() {
  const { data: session } = useSession();
  return (
    <nav className="bg-white border-gray-200 dark:bg-gray-900">
      <div className="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
        <div className="flex items-center">
          {/* TODO : change logo image */}
          <img
            src="https://flowbite.com/docs/images/logo.svg"
            className="h-8 mr-3"
            alt="Flowbite Logo"
          />
          <span className="self-center text-2xl font-semibold whitespace-nowrap dark:text-white">
            Karma
          </span>
        </div>

        <div className="hidden w-full md:block md:w-auto" id="navbar-default">
          <ul className="font-medium flex flex-col p-4 md:p-0 mt-4 border border-gray-100 rounded-lg bg-gray-50 md:flex-row md:space-x-8 md:mt-0 md:border-0 md:bg-white dark:bg-gray-800 md:dark:bg-gray-900 dark:border-gray-700">
            {/* Nav Items */}
            {(session?.user ? navItems.logined : navItems.notLogined).map(
              (item, idx) => (
                <NavItemComponent key={idx} {...item} />
              )
            )}
            {/* Sign in & Sign Out Button */}
            {session?.user ? (
              <NavItemComponent label={""} path={""}></NavItemComponent>
            ) : (
              <NavItemComponent label={""} path={""}></NavItemComponent>
            )}
          </ul>
        </div>
      </div>
    </nav>
  );
}
