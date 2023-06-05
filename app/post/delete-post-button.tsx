"use client";

import { useState } from "react";

export default function DeletePostButton(props: {
  _id: string;
  deletePost: Function;
}) {
  if (!props._id || !(typeof props._id === "string")) {
    return <></>;
  }
  const [isLoading, setIsLoading] = useState(false);
  const handleDeletePost = async () => {
    try {
      setIsLoading(true);
      await props.deletePost(props._id);
    } catch (err) {
      console.error(err);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <button disabled={isLoading} onClick={handleDeletePost}>
      Delete
    </button>
  );
}
