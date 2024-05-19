"use client";

import { Input } from "@nextui-org/react";
import { Dispatch, SetStateAction } from "react";

interface Props {
  value: string;
  setValue: Dispatch<SetStateAction<string>>;
  maxLength?: number;
  label?: string;
  labelPlacement?: "inside" | "outside";
  placehoder?: string;
}

export default function CustomInput(props: Props) {
  return (
    <div>
      <Input
        maxLength={props.maxLength}
        size="lg"
        label={props.label}
        labelPlacement={props.labelPlacement ?? "outside"}
        placeholder={props.placehoder}
        value={props.value}
        onValueChange={props.setValue}
      />

      {props.maxLength && (
        <div className="justify-end flex">
          <span className="text-slate-500">
            {props.value.length}/{props.maxLength}
          </span>
        </div>
      )}
    </div>
  );
}
