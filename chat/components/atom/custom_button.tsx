"use client";

import { Button } from "../ui/button";
import { useState } from "react";
import { toast } from "sonner";

interface Props {
  label: string;
  variant?:
    | "default"
    | "destructive"
    | "outline"
    | "secondary"
    | "ghost"
    | "link";
  clsName?: string;
  successMessage?: string;
  errorsMessage?: string;
  handleClick: () => Promise<any>;
}

export default function CustomButton(props: Props) {
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const handleClick = async () => {
    setIsLoading(true);
    await props
      .handleClick()
      .then(() => {
        if (props.successMessage) {
          toast.success(props.successMessage);
        }
      })
      .catch((err) => {
        if (props.errorsMessage) {
          toast.error(props.errorsMessage);
        }
        console.error(err);
      })
      .finally(() => {
        setIsLoading(false);
      });
  };

  return (
    <Button
      className={`w-full rounded-lg ${
        isLoading ? "cursor-wait" : "cursor-pointer"
      } ${props.clsName}`}
      variant={props.variant}
      onClick={handleClick}
      disabled={isLoading}
    >
      {props.label}
    </Button>
  );
}
