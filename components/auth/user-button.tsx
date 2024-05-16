"use client";

import useAuth from "@/lib/store/auth/auth_state";
import { Button } from "@nextui-org/react";

export default function UserButton() {
  const { user } = useAuth();

  //   TODO : 유저 정보를 보여주는 버튼 만들기
  return (
    <Button
      onClick={() => {
        console.log(user);
      }}
    >
      {user?.user_metadata["name"]}
    </Button>
  );
}
