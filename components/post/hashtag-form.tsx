"use client";

import { faHashtag, faRemove } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Chip, Input } from "@nextui-org/react";
import { Dispatch, SetStateAction, useState } from "react";
import { toast } from "react-toastify";

interface Props {
  hashtags: string[];
  setHashtags: Dispatch<SetStateAction<string[]>>;
  isEdit: boolean;
}

export default function HashatagForm(props: Props) {
  const MAX_LENGTH = 20;
  const MIN_LENTH = 3;
  const MAX_NUM = 3;

  const [value, setValue] = useState<string>("");

  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key != "Enter") {
      return;
    }
    if (value.length < MIN_LENTH) {
      toast.warn(`minimum length is ${MIN_LENTH}`);
      return;
    }
    if (props.hashtags.includes(value.trim())) {
      toast.warn("Duplicated Hastag!");
      return;
    }
    props.setHashtags([...props.hashtags, value]);
    setValue("");
  };

  const handleDelete = (index: number) => () => {
    let hashtags = [...props.hashtags];
    hashtags.splice(index, 1);
    props.setHashtags(hashtags);
  };

  return (
    <>
      <div>
        <Input
          disabled={props.hashtags.length >= MAX_NUM}
          startContent={
            <i className="text-sm">
              <FontAwesomeIcon icon={faHashtag} className="text-sm" />
            </i>
          }
          label={
            <div className="flex">
              <strong>HASHTAG</strong>
              <span className="mx-2 text-sm text-slate-500">
                {props.hashtags.length}/{MAX_NUM}
              </span>
            </div>
          }
          labelPlacement="outside"
          className="w-full"
          maxLength={MAX_LENGTH}
          isClearable
          radius="lg"
          value={value}
          size="lg"
          onValueChange={setValue}
          onKeyDown={handleKeyDown}
        />
        <div className="flex justify-end">
          <span className="text-slate-500 text-sm">
            {value.length}/{MAX_LENGTH}
          </span>
        </div>
      </div>

      <ul className="flex justify-start">
        {props.hashtags.map((hashtag, index) => (
          <li key={index}>
            <Chip
              className="mx-2 hover:bg-orange-400"
              endContent={
                !props.isEdit && (
                  <i
                    onClick={handleDelete(index)}
                    className="text-rose-400 rounded-full hover:cursor-pointer hover:text-white"
                  >
                    <FontAwesomeIcon icon={faRemove} />
                  </i>
                )
              }
            >
              <label>{hashtag}</label>
            </Chip>
          </li>
        ))}
      </ul>
    </>
  );
}
