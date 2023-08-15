"use client";

interface AtomProps {
  errorMessage: string | null;
}

import { ExclamationCircleIcon } from "@heroicons/react/24/solid";
import { XMarkIcon } from "@heroicons/react/24/solid";
import { useState } from "react";

export default function AlertAtom(props: AtomProps) {
  const [visible, setVisible] = useState<boolean>(true);
  const handleVisible = () => setVisible(false);

  if (!props.errorMessage) return;

  return (
    visible && (
      <div
        className="flex p-4 mb-4 text-red-500 rounded-lg bg-red-50 dark:bg-gray-800 dark:text-red-300 items-center"
        role="alert"
      >
        <ExclamationCircleIcon className="h-6 w-6" />
        <div className="ml-3 text-md font-medium">{props.errorMessage}</div>
        <button
          onClick={handleVisible}
          type="button"
          className="ml-auto -mx-1.5 -my-1.5 bg-red-50 text-red-500 rounded-lg focus:ring-2 focus:ring-red-300 p-1.5 hover:bg-red-200 inline-flex h-8 w-8 dark:bg-gray-800 dark:text-red-400 dark:hover:bg-gray-700"
          data-dismiss-target="#alert-1"
          aria-label="Close"
        >
          <XMarkIcon />
        </button>
      </div>
    )
  );
}
