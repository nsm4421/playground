"use client";

import { Button } from "@/components/ui/button";
import { CiMail } from "react-icons/ci";
import { FaGithub } from "react-icons/fa";

interface Props {
  provider: "email" | "github";
}

export default function SignUpButton(props: Props) {
  switch (props.provider) {
    case "email":
      return SignUpWithEmailButton();

    case "github":
      return SignUpWithGithubButton();
    default:
      return <></>;
  }
}

function SignUpWithEmailButton() {
  // TODO : sign up function
  const handleSignUp = () => {};

  return (
    <Button className="text-lg gap-x-2" onClick={handleSignUp}>
      <span className="hover:text-rose-500"> Sign Up With Email</span>
      <CiMail />
    </Button>
  );
}

function SignUpWithGithubButton() {
  // TODO : sign up function
  const handleSignUp = () => {};

  return (
    <Button className="text-lg gap-x-2" onClick={handleSignUp}>
      <span className="hover:text-rose-500"> Sign Up With Github</span>
      <FaGithub />
    </Button>
  );
}
