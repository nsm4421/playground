"use client"

import { signOut } from "next-auth/react";
import CustomButton from "../atom/custom_button";

interface Props {
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

export default function SignOutButton(props: Props) {
  return (
    <CustomButton
      variant="outline"
      {...props}
      label={props.label ?? "SIGN OUT"}
      handleClick={async () => await signOut()}
    />
  );
}
