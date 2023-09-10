"use client";

import sideBarItems from "@/lib/const/side-bar-items";
import Link from "next/link";
import Image from "next/image";
import { usePathname, useRouter } from "next/navigation";

/**
 * Bottom navigationbar for mobile view
 */
export default function BottomNavComponent() {
  const pathname = usePathname();
  const router = useRouter();

  // TODO : 로그아웃 처리
  const handleLogout = () => router.push("/");

  return (
    <section className="bottom-nav">
      {sideBarItems.map((item, idx) => {
        const clsName =
          (pathname.includes(item.href) && item.href.length > 1) ||
          pathname === item.href
            ? "bottom-nav-item-active"
            : "bottom-nav-item";
        return (
          <li key={idx} className={`${clsName}`}>
            <Link href={item.href}>
              <div className="flex justify-center">
                <Image
                  src={item.imgSrc}
                  alt={item.label}
                  width={25}
                  height={25}
                />
              </div>
            </Link>
            <p className="bottom-nav-item-label">{item.label}</p>
          </li>
        );
      })}
      {/* Logout button */}
      <li className="bottom-nav-item cursor-pointer" onClick={handleLogout}>
        <div className="flex justify-center">
          <Image src="assets/logout.svg" alt="logout" width={25} height={25} />
        </div>
        <p className="bottom-nav-item-label">Logout</p>
      </li>
    </section>
  );
}
