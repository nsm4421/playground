"use client";

import { useUser } from "@/lib/store/user/user";
import SocialLoginButton from "./social_login_button";
import LogOutButton from "./logout_button";

export default function LoginButtons() {
  const { sessionUser } = useUser();

  if (sessionUser) {
    return (
      <ul className="mt-10 w-10/12 justify-center">
        <LogOutButton />
      </ul>
    );
  } else {
    return (
      <ul className="mt-10 mx-auto w-full justify-center">
        <li className="w-10/12 mt-3">
          <SocialLoginButton provider="google" loginLabel="구글로 로그인" />
        </li>

        <li className="w-10/12 mt-3">
          <SocialLoginButton provider="github" loginLabel="깃허브로 로그인" />
        </li>
      </ul>
    );
  }
}
