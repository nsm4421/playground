import { ChangeEvent, useState } from "react";

export default function useInput(
  initValue?: string | null,
  validator?: (value: string) => boolean
) {
  const [value, setValue] = useState<string>(initValue ?? "");
  const clear = () => setValue("");
  const onChange = (e: ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    const {
      target: { value: v },
    } = e;
    let willUpdate = true;
    if (typeof validator === "function") willUpdate = validator(v);
    if (willUpdate) setValue(e.target.value);
  };
  return { value, setValue, onChange, clear };
}
