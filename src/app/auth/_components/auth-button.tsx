"use client";

import { Button } from "@/lib/ui/button";

export default function AuthButton() {
  const handleSignUp = async () => {};
  const handleSignIn = async () => {};

  return (
    <div className="flex gap-x-3 items-center">
      <Button
        onClick={handleSignUp}
        className="w-full text-white"
        variant={"outline"}
      >
        Sign Up
      </Button>
      <Button onClick={handleSignIn} className="w-full">
        Sign In
      </Button>
    </div>
  );
}
