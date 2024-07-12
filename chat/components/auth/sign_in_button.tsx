"use client";

import { signIn } from "next-auth/react";
import CustomButton from "../atom/custom_button";
import { AuthProvider } from "@/lib/const/constant";

interface Props {
  provider: AuthProvider;
  varaint?:
    | "link"
    | "outline"
    | "default"
    | "destructive"
    | "secondary"
    | "ghost"
    | undefined;
  label?: string;
  clsName?: string;
}
export default function SignInButton(props: Props) {
  return (
    <CustomButton
      {...props}
      label={props.label ?? "SIGN IN"}
      handleClick={async () => await signIn(props.provider)}
    />
  );
}
