"use client";

import { useSession } from "next-auth/react";
import SignInButton from "./signin-button-component";
import SignOutButton from "./signout-button-component";

export default function NavComponent() {
  let session = useSession();

  // login
  if (session.data?.user) {
    return (
      <div>
        <h1>Login</h1>
        <hr />
        <div>
          <label>Username</label>
          <br />
          <span>{session.data.user.name}</span>
        </div>
        <hr />
        <div>
          <label>Email</label>
          <br />
          <span>{session.data.user.email}</span>
        </div>
       <hr/>
       <SignOutButton/>
      </div>
    );
  }

  // not login
  return (
    <div>
      <h1>Not Login</h1>
      <SignInButton />
    </div>
  );
}
