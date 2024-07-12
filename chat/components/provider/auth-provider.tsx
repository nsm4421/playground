"use client"

import { SessionProvider } from "next-auth/react";
import type { ReactNode } from "react";

interface Props {
  children: ReactNode;
}

export default function NextAuthProvider(props: Props) {
  return <SessionProvider {...props} />;
}
