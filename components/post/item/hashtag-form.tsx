"use client";

import { faAdd, faHashtag, faRemove } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Chip, Input } from "@nextui-org/react";
import { Dispatch, SetStateAction, useState } from "react";
import { toast } from "react-toastify";

interface Props {
  hashtags: string[];
  setHashtags: Dispatch<SetStateAction<string[]>>;
  hideLabel?: boolean;
  hideCounterText?: boolean;
  placeholder?: string;
  isEdit: boolean; // 해시태그 삭제 가능 여부
  maxLength?: number; // 해시태그 최대길이
  maxNum?: number; //  해시태그 최대개수
  minLength?: number; // 해시태그 최소길이
}

export default function HashatagForm(props: Props) {
  const [value, setValue] = useState<string>("");

  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key != "Enter") {
      return;
    }
    handleAdd();
  };

  const handleAdd = () => {
    if (props.minLength && value.length < props.minLength) {
      toast.warn(`minimum length is ${props.minLength}`);
      return;
    }
    if (props.hashtags.includes(value.trim())) {
      toast.warn("Duplicated Hashtag!");
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
          disabled={props.hashtags.length >= (props.maxNum ?? 3)}
          startContent={
            <i className="text-sm">
              <FontAwesomeIcon icon={faHashtag} className="text-sm" />
            </i>
          }
          endContent={
            <i className="text-sm" onClick={handleAdd}>
              <FontAwesomeIcon icon={faAdd} className="text-sm" />
            </i>
          }
          label={
            !props.hideLabel && (
              <div className="flex">
                <strong>HASHTAG</strong>
                <span className="mx-2 text-sm text-slate-500">
                  {props.hashtags.length}/{props.maxNum ?? 3}
                </span>
              </div>
            )
          }
          labelPlacement="outside"
          className="w-full"
          maxLength={props.maxLength ?? 20}
          radius="lg"
          value={value}
          size="lg"
          onValueChange={setValue}
          onKeyDown={handleKeyDown}
          placeholder={props.placeholder}
        />
        {!props.hideCounterText && (
          <div className="flex justify-end">
            <span className="text-slate-500 text-sm">
              {value.length}/{props.maxLength ?? 20}
            </span>
          </div>
        )}
      </div>

      <ul className="flex justify-start mt-2">
        {props.hashtags.map((hashtag, index) => (
          <li key={index}>
            <Chip
              className="mx-2 hover:bg-orange-400"
              endContent={
                props.isEdit && (
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
