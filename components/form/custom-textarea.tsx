"use client";

import { Input, Textarea } from "@nextui-org/react";
import { Dispatch, SetStateAction } from "react";

interface Props {
  value: string;
  setValue: Dispatch<SetStateAction<string>>;
  maxRows? : number;
  maxLength?: number;
  label?: string;
  labelPlacement?: "inside" | "outside";
  placehoder?: string;
}

export default function CustomTextarea(props: Props) {
  return (
    <div>
      <Textarea
        maxLength={props.maxLength}
        maxRows={props.maxRows}
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
