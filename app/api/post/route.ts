import createSupbaseServerClient from "@/lib/supabase/client/server-client";
import { NextResponse } from "next/server";

interface Props {
  title: string;
  content: string;
  hashtags: string[];
}

export async function POST(request: Request) {
  const supabase = await createSupbaseServerClient();

  const props: Props = await request.json();

  const res = await supabase.from("posts").insert({
    ...props,
  });

  // return
  return NextResponse.json(
    { payload: res.data },
    { status: res.status, statusText: res.statusText }
  );
}
