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

interface Props {
  message: IMessage;
}

export default function ChatMesssageItem(props: Props) {
  const dt = new Date(props.message.created_at).toDateString();
  const currentUser = useUser().currentUser;
  const setActionMessage = useMessage().setActionMessage;

  const handleClickDelete = () => {
    setActionMessage(props.message);
    document.getElementById(`trigger-delete-${props.message.id}`)?.click();
  };

  return (
    <>
      {/* 프로필 이미지 */}
      <div className="w-10 h-10">
        {props.message.user?.profile_image && (
          <Image     
            width={30}
            height={30}
            src={props.message.user?.profile_image}
            alt={props.message.user.id}
            className="rounded-full"
          />
        )}
      </div>

      <div className="flex-1">
        <div className="flex items-center gap-1 justify-between">
          {/* 작성자, 작성시간 */}
          <div>
            <p className="font-bold">{props.message.user?.username}</p>
            <p className="text-sm text-gray-400">{dt}</p>
          </div>

          {/* 아이콘 */}
          <div>
            {props.message.created_by === currentUser?.id && (
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
        </div>

        {/* 본문 */}
        {props.message.removed_at ? (
          <p className="text-slate-400 dark:text-gray-800">
            삭제된 메세지 입니다
          </p>
        ) : (
          <p className="text-black dark:text-gray-300">
            {props.message.content}
          </p>
        )}
      </div>

      {/* 모달창 */}
      <DeleteChatMessageDialog />
    </>
  );
}
