import { ChangeEvent, Dispatch, SetStateAction } from "react";

interface AtomProps {
  value: string;
  rows?: number;
  onChange: (e: ChangeEvent<HTMLTextAreaElement>) => void;
  id?: string;
  label?: string;
  placeholder?: string;
  required?: boolean;
}

export default function TextareaAtom(props: AtomProps) {
  return (
    <div>
      {props.label && (
        <label className="block mb-2 text-md font-medium text-gray-900 dark:text-white">
          {props.label}
        </label>
      )}
      <textarea
        value={props.value}
        onChange={props.onChange}
        id={props.id}
        rows={props.rows ?? 10}
        className="bg-gray-50 border resize-none border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
        placeholder={props.placeholder ?? ""}
        required={props.required ?? false}
      />
    </div>
  );
}
