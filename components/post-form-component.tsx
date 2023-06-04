"use client";

import { WritePostData } from "@/util/model";
import { useRouter } from "next/navigation";
import {
  ChangeEvent,
  Dispatch,
  SetStateAction,
  useEffect,
  useState,
} from "react";

export default function PostFormComponent(props: {
  isLoading: boolean;
  setIsLoading: Dispatch<SetStateAction<boolean>>;
  initCallback?: Function;
  submitCallback: Function;
}) {
  const router = useRouter();
  const [input, setInput] = useState<WritePostData>({
    title: "",
    content: "",
  });
  const handleInput = (field: string) => (e: ChangeEvent<HTMLInputElement>) => {
    setInput({ ...input, [field]: e.target.value });
  };

  const handleGoBack = () => router.back();
  const handleSubmit = () => {
    props.submitCallback(input);
  };

  useEffect(() => {
    if (props.initCallback){
      props.initCallback(setInput)
    }
    return;
  }, []);
  
  return (
    <>
      <div>
        <label>Title</label>
        <input
          value={input?.title}
          placeholder="title"
          onChange={handleInput("title")}
        />
      </div>
      <div>
        <label>Content</label>
        <input
          value={input?.content}
          placeholder="content"
          onChange={handleInput("content")}
        />
      </div>
      <div>
        <button disabled={props.isLoading} type="submit" onClick={handleSubmit}>
          Submit
        </button>
      </div>
      <div>
        <button disabled={props.isLoading} type="button" onClick={handleGoBack}>
          Go Back
        </button>
      </div>
    </>
  );
}
