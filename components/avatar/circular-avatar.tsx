import { User } from "@supabase/supabase-js";
import { cn } from "@/lib/utils";
import { AiFillQuestionCircle } from "react-icons/ai";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";

interface Props {
  user: User;
  size?: 24 | 32 | 48;
}

export default function CircularAvatar({ user, size = 32 }: Props) {
  const src = user?.user_metadata?.profile_image as string;
  if (src) {
    return (
      <Avatar>
        <AvatarImage src={src} alt="profile-image" />
        <AvatarFallback>Loadings...</AvatarFallback>
      </Avatar>
    );
  } else {
    return (
      <i
        className={cn(
          "relative",
          `w-${size}`,
          `h-${size}`,
          "rounded-full bg-slate-500"
        )}
      >
        <AiFillQuestionCircle className="w-full h-full" />
      </i>
    );
  }
}
