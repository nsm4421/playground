"use client";
import { signIn } from "next-auth/react";

export default function SignInButton() {
  const handleLogin = () => {
    signIn();
  };
  return <button onClick={handleLogin}>Login</button>;
}
