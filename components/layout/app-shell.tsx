"use client";

import sideBarItems from "@/lib/const/side-bar-items";
import Link from "next/link";
import Image from "next/image";
import { usePathname, useRouter } from "next/navigation";

/**
 * Left Side Bar
 */
export default function AppShellComponent() {
  const pathname = usePathname();
  const router = useRouter();

  // TODO : 로그아웃 처리
  const handleLogout = () => router.push("/");

  return (
    <section className="app-shell">
      {sideBarItems.map((item, idx) => {
        const clsName =
          (pathname.includes(item.href) && item.href.length > 1) ||
          pathname === item.href
            ? "app-shell-item-active"
            : "app-shell-item";
        return (
          <li key={idx}>
            <Link href={item.href} className={clsName}>
              <Image
                src={item.imgSrc}
                alt={item.label}
                width={25}
                height={25}
              />
              <p className="app-shell-item-label">{item.label}</p>
            </Link>
          </li>
        );
      })}
      {/* Logout button */}
      <li className="app-shell-item cursor-pointer" onClick={handleLogout}>
        <Image
          src={"assets/logout.svg"}
          alt={"logout"}
          width={25}
          height={25}
        />
        <p className="app-shell-item-label">Logout</p>
      </li>
    </section>
  );
}
