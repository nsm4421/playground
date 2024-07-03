"use client";

import { Button } from "@/components/ui/button";
import { FaGithub } from "react-icons/fa";

interface Props {
  provider: "github";
}

export default function SignUpButton(props: Props) {
  switch (props.provider) {
    case "github":
      return SignUpWithGithubButton();
    default:
      return <></>
  }
}

function SignUpWithGithubButton() {
  // TODO : sign up function
  const handleSignUp = () => {};

  return (
    <div>
      <Button className="text-lg gap-x-2" onClick={handleSignUp}>
        <span> Sign Up With Github</span>
        <FaGithub />
      </Button>
    </div>
  );
}
