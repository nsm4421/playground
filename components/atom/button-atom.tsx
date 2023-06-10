interface AtomProps {
  onClick?: Function;
  disabled: boolean;
  id?: string;
  label?: string;
  color?: "green" | "yellow" | "blue";
}

export default function ButtonAtom(props: AtomProps) {
  const handleOnClick = () => {
    if (props.onClick) props.onClick();
  };
  let clsName: string | null;
  const clsNameDisabled =
    "text-gray-900 bg-white border border-gray-300 focus:outline-none hover:bg-gray-100 focus:ring-4 focus:ring-gray-200 font-medium rounded-full text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-gray-800 dark:text-white dark:border-gray-600 dark:hover:bg-gray-700 dark:hover:border-gray-600 dark:focus:ring-gray-700 cursor-not-allowed";

  switch (props.color) {
    case "green":
      clsName =
        "text-white bg-green-700 hover:bg-green-800 focus:outline-none focus:ring-4 focus:ring-green-300 font-medium rounded-full text-sm px-5 py-2.5 text-center mr-2 mb-2 dark:bg-green-600 dark:hover:bg-green-700 dark:focus:ring-green-800";
      break;
    case "yellow":
      clsName =
        "text-white bg-yellow-400 hover:bg-yellow-500 focus:outline-none focus:ring-4 focus:ring-yellow-300 font-medium rounded-full text-sm px-5 py-2.5 text-center mr-2 mb-2 dark:focus:ring-yellow-900";
      break;
    default: // blue
      clsName =
        "text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800";
  }
  return (
    <button
      disabled={props.disabled}
      className={props.disabled ? clsNameDisabled : clsName}
      onClick={handleOnClick}
    >
      {props.label}
    </button>
  );
}
