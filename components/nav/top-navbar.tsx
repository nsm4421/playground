"use client";

import React, { useState } from "react";
import {
  Navbar,
  NavbarBrand,
  NavbarContent,
  NavbarItem,
  NavbarMenuToggle,
  NavbarMenu,
  NavbarMenuItem,
  Link,
} from "@nextui-org/react";
import NavItems from "@/lib/contant/nav-items";
import UserButton from "../auth/user-button";
import InitAuth from "@/lib/store/auth/init_auth";

export default function TopNavbar() {
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  return (
    <nav className="w-full">
      <Navbar onMenuOpenChange={setIsMenuOpen}>
        <NavbarContent>
          <NavbarMenuToggle
            aria-label={isMenuOpen ? "Close menu" : "Open menu"}
            className="sm:hidden"
          />
          <NavbarBrand>
            <Link href="/">
              <p className="font-extrabold text-inherit text-2xl cursor-pointer">
                TRAVELER
              </p>
            </Link>
          </NavbarBrand>
        </NavbarContent>

        {/* 화면이 넓을 때 보여줄 메뉴 */}
        <NavbarContent className="hidden sm:flex gap-4" justify="center">
          {NavItems.map((item, index) => (
            <NavbarItem key={`${item}-${index}`}>
              <Link
                className="w-full text-black dark:text-white hover:font-bold hover:text-orange-600"
                href={item.href}
                size="lg"
              >
                {item.label}
              </Link>
            </NavbarItem>
          ))}
        </NavbarContent>

        {/* 유저 버튼 */}
        <NavbarContent justify="end">
          <NavbarItem>
            <UserButton />
          </NavbarItem>
        </NavbarContent>

        {/* 화면이 넓을 때 보여줄 메뉴 */}
        <NavbarMenu>
          {NavItems.map((item, index) => (
            <NavbarMenuItem key={`${item}-${index}`}>
              <Link
                className="w-full text-black dark:text-white hover:font-bold hover:text-orange-600"
                href={item.href}
                size="lg"
              >
                {item.label}
              </Link>
            </NavbarMenuItem>
          ))}
        </NavbarMenu>
      </Navbar>
      <InitAuth/>
    </nav>
  );
}
