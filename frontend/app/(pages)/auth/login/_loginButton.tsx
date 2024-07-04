"use client";

import { Button } from "@/components/ui/button";
import { FaGithub } from "react-icons/fa";

interface Props {
  provider: "github";
}

export default function LoginButton(props: Props) {
  switch (props.provider) {
    case "github":
      return LoginWithGithubButton();
    default:
      return <></>
  }
}

function LoginWithGithubButton() {
  // TODO : sign up function
  const handleLogin = () => {};

  return (
    <div>
      <Button className="text-lg gap-x-2" onClick={handleLogin}>
        <span> Sign In With Github</span>
        <FaGithub />
      </Button>
    </div>
  );
}
