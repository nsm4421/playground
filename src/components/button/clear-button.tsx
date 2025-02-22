"use client";

interface Props {
  onClick?: () => void;
  clsName?: string;
}

export default function ClearIconButton({ onClick, clsName }: Props) {
  return (
    <button onClick={onClick}>
      <ClearIconButton clsName={clsName} />
    </button>
  );
}
