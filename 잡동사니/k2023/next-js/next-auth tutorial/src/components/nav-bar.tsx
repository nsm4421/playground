"use client";

import { signOut, useSession } from "next-auth/react";
import Image from "next/image";
import Link from "next/link";
import { usePathname } from "next/navigation";

const linksNotLogin = [
  {
    label: "Home",
    href: "/",
  },
  {
    label: "Register",
    href: "/auth/register",
  },
  {
    label: "Login",
    href: "/auth/login",
  },
];

const linksLogin = [
  {
    label: "Home",
    href: "/",
  },
];

export default function NavBar() {
  const pathname = usePathname();
  const { data: session } = useSession();

  const handleLogout = () => {signOut()}

  const LinkBtn = (props: { href: string; label: string }) => (
    <Link href={props.href}>
      <span className={pathname === props.href ? "bg-rose-650" : ""}>
        {props.label}
      </span>
    </Link>
  );

  // login
  if (session) {
    return (
      <nav>
        <Image src={"/vercel.svg"} alt={"logo"} width="100" height="100" />
        <div>
          {linksLogin.map((link, idx) => (
            <LinkBtn {...link} key={idx} />
          ))}
          <button onClick={handleLogout}>Logout</button>
        </div>
      </nav>
    );
  }

  // not login
  return (
    <nav>
      <Image src={"/vercel.svg"} alt={"logo"} width="100" height="100" />
      <div>
        {linksNotLogin.map((link, idx) => (
          <LinkBtn {...link} key={idx} />
        ))}
      </div>
    </nav>
  );
}
