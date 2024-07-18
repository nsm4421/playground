"use client";

import useAuth from "@/lib/hooks/use-auth";
import { Button } from "../ui/button";
import Link from "next/link";

export default function Navbar() {
  const { isAuthroized, user, signOut } = useAuth();

  return (
    <nav className="flex justify-between px-2">
      <h1 className="text-xl font-semibold hover:text-orange-500">
        <Link href="/">Karma</Link>
      </h1>

      {isAuthroized && user ? (
        // 회원가입 한 경우
        <ul className="flex justify-center gay-x-3">
          <li>
            <Link href="/chat">
              <Button variant="ghost" className="hover:text-orange-500">
                Chat
              </Button>
            </Link>
          </li>
          <li>
            <Button
              onClick={signOut}
              variant="ghost"
              className="hover:text-orange-500"
            >
              Logout
            </Button>
          </li>
        </ul>
      ) : (
        // 회원가입하지 않은 경우
        <div>
          <ul className="flex justify-center gay-x-3">
            <li>
              <Link href="/sign-up">
                <Button variant="ghost" className="hover:text-orange-500">
                  Sign UP
                </Button>
              </Link>
            </li>
            <li>
              <Link href="/sign-in">
                <Button variant="ghost" className="hover:text-orange-500">
                  Sign In
                </Button>
              </Link>
            </li>
          </ul>
        </div>
      )}
    </nav>
  );
}
