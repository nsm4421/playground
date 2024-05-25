import { RealtimeChannel } from "@supabase/supabase-js";
import createSupabaseBrowerCleint from "../client/browser-client";

interface Props {
  channel: RealtimeChannel;
}

export default async function removeSupbaseChannel({ channel }: Props) {
  const supabase = createSupabaseBrowerCleint();
  await supabase.removeChannel(channel);
}
