"use client";

import React from "react";
import {
  Modal,
  ModalContent,
  ModalHeader,
  ModalBody,
  ModalFooter,
  Input,
  Textarea,
} from "@nextui-org/react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faComment,
  faMessage,
  faPaperPlane,
} from "@fortawesome/free-solid-svg-icons";

interface Props {
  postId: string;
  size?: "md" | "xl" | "2xl" | "3xl";
  isOpen: boolean;
  onOpenChage: () => void;
}

export default function PostCommentModel(props: Props) {
  const maxLength = 500;
  // TODO
  const handleSubmitComment = () => {};

  return (
    <Modal
      className="w-full"
      size={props.size ?? "2xl"}
      isOpen={props.isOpen}
      onOpenChange={props.onOpenChage}
      placement="top-center"
      backdrop="blur"
    >
      <ModalContent>
        {(onClose) => (
          <>
            <ModalHeader className="flex flex-col gap-1">
              <div className="flex justify-start items-center gap-x-2">
                <i>
                  <FontAwesomeIcon icon={faComment} />
                </i>
                <h1 className="text-xl font-bold"> COMMENT</h1>
              </div>
            </ModalHeader>

            {/* 댓글 목록 */}
            <ModalBody>
                
            </ModalBody>

            {/* 댓글 작성 */}
            <ModalFooter>
              <Input
                maxLength={maxLength}
                placeholder="Write Comment"
                // 댓글 제출 버튼
                endContent={
                  <button
                    className="rounded-full hover:cursor-pointer hover:bg-orange-500 w-10 h-10 p-1"
                    onClick={handleSubmitComment}
                  >
                    <FontAwesomeIcon icon={faPaperPlane} />
                  </button>
                }
              />
            </ModalFooter>
          </>
        )}
      </ModalContent>
    </Modal>
  );
}
