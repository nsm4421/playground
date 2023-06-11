import { ReactNode } from "react";

interface AtomProps {
  onClick?: Function;
  disabled: boolean;
  id?: string;
  label?: string;
  icon: ReactNode;
}

export default function IconButtonAtom(props: AtomProps) {
  const handleOnClick = () => {
    if (props.onClick) props.onClick();
  };
  return (
    <button
      id={props.id}
      disabled={props.disabled}
      className="text-gray-900 bg-white hover:bg-gray-100 border border-gray-200 focus:ring-4 focus:outline-none focus:ring-gray-100 font-medium rounded-lg text-sm px-5 py-2.5 text-center inline-flex items-center dark:focus:ring-gray-600 dark:bg-gray-800 dark:border-gray-700 dark:text-white dark:hover:bg-gray-700 mr-2 mb-2"
      onClick={handleOnClick}
    >
      {props.icon}
      <span className="pl-2">{props.label}</span>
    </button>
  );
}
