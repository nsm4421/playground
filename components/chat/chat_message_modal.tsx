"use client";

import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger,
} from "@/components/ui/alert-dialog";
import { useMessage } from "@/lib/store/message/message";
import getSupbaseBrowser from "@/lib/supabase/browser";
import { useState } from "react";
import { toast } from "sonner";

export function DeleteChatMessageDialog() {
  const [isLoading, setIsLoading] = useState(false);
  const supabase = getSupbaseBrowser();
  const softDeleteMessage = useMessage((state) => state.softDeleteMessage);
  const actionMessage = useMessage((state) => state.actionMessage);

  const setActionMessage = useMessage((state) => state.setActionMessage);

  const handleAction = async () => {
    try {
      setIsLoading(true);
      const removedAt = new Date().toISOString();
      const { error } = await supabase
        .from("messages")
        .update({
          removed_at: removedAt,
        })
        .eq("id", actionMessage!.id);
      if (error) {
        toast.error(error.message);
        console.error(error);
        return;
      } else {
        softDeleteMessage({ messageId: actionMessage!.id, removedAt });
        setActionMessage(undefined);
        toast.success("메세지를 삭제 성공");
      }
    } catch (err) {
      toast.error("메세지 삭제 실패");
      console.error(err);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <AlertDialog>
      <AlertDialogTrigger asChild>
        <button
          id={`trigger-delete-${actionMessage?.id}`}
          disabled={isLoading}
        ></button>
      </AlertDialogTrigger>
      <AlertDialogContent>
        <AlertDialogHeader>
          <AlertDialogTitle>Delete</AlertDialogTitle>
          <AlertDialogDescription>
            삭제된 메세지는 복구할 수 없습니다
          </AlertDialogDescription>
        </AlertDialogHeader>
        <AlertDialogFooter>
          <AlertDialogCancel>취소하기</AlertDialogCancel>
          <AlertDialogAction onClick={handleAction}>삭제하기</AlertDialogAction>
        </AlertDialogFooter>
      </AlertDialogContent>
    </AlertDialog>
  );
}
