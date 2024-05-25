import { RealtimePostgresInsertPayload } from "@supabase/supabase-js";
import createSupabaseBrowerCleint from "../client/browser-client";

interface Props {
  channelName: string;
  event: "INSERT";
  schema?: string;
  table: string;
  filter?: string | undefined;
  callback: (
    payload: RealtimePostgresInsertPayload<{
      [key: string]: any;
    }>
  ) => void;
}

export default function getSupabaseChannel(props: Props) {
  const supabase = createSupabaseBrowerCleint();
  return supabase
    .channel(props.channelName)
    .on(
      "postgres_changes",
      {
        event: props.event ?? "INSERT",
        schema: props.schema ?? "public",
        table: props.table,
      },
      props.callback
    )
    .subscribe();
}
