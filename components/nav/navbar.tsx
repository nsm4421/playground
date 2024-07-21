"use client";

import useAuth from "@/lib/provider/use-auth";
import { Button } from "../ui/button";
import Link from "next/link";
import CircularAvatar from "../avatar/circular-avatar";
import {
  HoverCard,
  HoverCardTrigger,
  HoverCardContent,
} from "@radix-ui/react-hover-card";
import { User } from "@supabase/supabase-js";
import { Routes } from "@/lib/constant/routes";

export default function Navbar() {
  const { isAuthroized, user, signOut } = useAuth();

  return (
    <nav className="flex justify-between items-center px-2">
      <h1 className="text-xl font-semibold hover:text-orange-500">
        <Link href={Routes.index}>Karma</Link>
      </h1>

      {isAuthroized && user ? (
        <OnLogin user={user} signOut={signOut} />
      ) : (
        <OnNotLogin />
      )}
    </nav>
  );
}

interface PropsForLogin {
  user: User;
  signOut: () => void;
}

function OnLogin({ user, signOut }: PropsForLogin) {
  return (
    <ul className="flex justify-between items-center gay-x-3">
      <li>
        <Link href={Routes.chat}>
          <Button variant="ghost" className="hover:text-orange-500">
            Chat
          </Button>
        </Link>
      </li>

      <li className="items-center">
        <HoverCard>
          <HoverCardTrigger asChild>
            <Button variant="ghost" className="h-full items-center">
              <CircularAvatar user={user} />
            </Button>
          </HoverCardTrigger>
          <HoverCardContent>
            <div className="p-3">
              <h1 className="text-md font-semibold p-2">
                {user?.user_metadata?.nickname ?? user.email}
              </h1>
              <ul className="flex justify-around p-2 space-x-2">
                <li>
                  <Link href={Routes.myPage}>
                    <Button variant="outline" className="hover:text-orange-500">
                      My Page
                    </Button>
                  </Link>
                </li>
                <li>
                  <Button
                    onClick={signOut}
                    variant="outline"
                    className="hover:text-orange-500"
                  >
                    Logout
                  </Button>
                </li>
              </ul>
            </div>
          </HoverCardContent>
        </HoverCard>
      </li>
    </ul>
  );
}

function OnNotLogin() {
  return (
    <div>
      <ul className="flex justify-center gay-x-3">
        <li>
          <Link href={Routes.signUp}>
            <Button variant="ghost" className="hover:text-orange-500">
              Sign UP
            </Button>
          </Link>
        </li>
        <li>
          <Link href={Routes.signIn}>
            <Button variant="ghost" className="hover:text-orange-500">
              Sign In
            </Button>
          </Link>
        </li>
      </ul>
    </div>
  );
}
