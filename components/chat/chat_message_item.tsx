import { IMessage, useMessage } from "@/lib/store/message/message";
import { useUser } from "@/lib/store/user/user";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuTrigger,
} from "@radix-ui/react-dropdown-menu";
import { MoreHorizontal } from "lucide-react";
import Image from "next/image";
import { DeleteChatMessageDialog } from "./chat_message_modal";
import { Avatar, AvatarFallback, AvatarImage } from "../ui/avatar";

interface Props {
  message: IMessage;
}

export default function ChatMesssageItem(props: Props) {
  const dt = new Date(props.message.created_at).toDateString();
  const { basicUser } = useUser();
  const { setActionMessage } = useMessage();

  const handleClickDelete = () => {
    setActionMessage(props.message);
    document.getElementById("trigger-delete")?.click();
  };

  return (
    <div className="w-full">
      <div className="flex justify-between space-x-4">
        {/* 프로필 사진 */}
        <div>
          <Avatar>
            <div className="w-10 h-10">
              {props.message.sender?.avatar_url && (
                <AvatarImage src={props.message.sender?.avatar_url} />
              )}
              <AvatarFallback>NO</AvatarFallback>
            </div>
          </Avatar>
        </div>

        <div className="space-y-1 w-full">
          <div className="justify-between flex w-full">
            {/* 닉네임 */}

            <h4 className="text-sm font-semibold">
              {props.message.sender?.username}
            </h4>

            {/* 아이콘 버튼 */}
            {props.message?.sender?.id === basicUser?.id && (
              <DropdownMenu>
                {/* 더보기 버튼 */}
                <DropdownMenuTrigger>
                  <MoreHorizontal />
                </DropdownMenuTrigger>
                <DropdownMenuContent>
                  {/* 삭제 버튼 */}
                  <DropdownMenuItem
                    onClick={handleClickDelete}
                    className="cursor-pointer hover:bg-slate-300 rounded-sm"
                  >
                    <DropdownMenuLabel>Delete</DropdownMenuLabel>
                  </DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>
            )}
          </div>

          {/* 메세지 */}
          <div className="w-full whitespace-normal break-all">
            {props.message.removed_at ? (
              <span className="text-slate-400 dark:text-gray-800 text-sm">
                삭제된 메세지 입니다
              </span>
            ) : (
              <span className="text-black dark:text-gray-300 text-lg flex">
                {props.message.content}
              </span>
            )}
          </div>

          {/* 날짜 */}
          <div className="flex items-center pt-2 text-sm text-slate-400 dark:text-gray-800">
            {dt}
          </div>
        </div>
      </div>

      {/* 모달창 */}
      <DeleteChatMessageDialog />
    </div>
  );
}
