"use client";

import { useRouter } from "next/navigation";
import BackIcon from "../icon/back-icon";

interface Props {
  onClick?: () => void;
  clsName?: string;
}

export default function BackButton({ onClick, clsName }: Props) {
  const router = useRouter();

  const handleGoBack = () => {
    router.back();
  };

  return (
    <button onClick={onClick ?? handleGoBack}>
      <BackIcon clsName={clsName} />
    </button>
  );
}
