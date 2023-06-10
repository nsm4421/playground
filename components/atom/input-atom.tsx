import { ChangeEvent, Dispatch, SetStateAction } from "react";

interface AtomProps {
  onChange: (e: ChangeEvent<HTMLInputElement>)=>void
  id?: string;
  label?: string;
  type?: "text" | "email" | "password";
  placeholder?: string;
  required?: boolean;
}

export default function InputAtom(props: AtomProps) {
  return (
    <div>
      {props.label && (
        <label className="block mb-2 text-md font-medium text-gray-900 dark:text-white">
          {props.label}
        </label>
      )}
      <input
        onChange={props.onChange}
        type={props.type ?? "text"}
        id={props.id}
        className="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
        placeholder={props.placeholder ?? ""}
        required={props.required ?? false}
      />
    </div>
  );
}
