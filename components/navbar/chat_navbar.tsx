"use client";

import { BasicUser, useUser } from "@/lib/store/user/user";
import getSupbaseBrowser from "@/lib/supabase/browser";
import { useEffect, useState } from "react";
import GoogleLoginButton from "../auth/google_login_button";

interface Payload {
  user: BasicUser;
  onlineAt: string;
}

export default function ChatNavbar() {
  const { basicUser } = useUser();

  return (
    <section className="bg-slate-700 p-3">
      <div>
        <div className="flex justify-between items-center">
          <div>
            <div className="flex text-white">
              {basicUser?.username ?? "Unknown"}
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
