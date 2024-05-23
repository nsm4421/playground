import { PostCommentWithAuthor, PostWithAuthor } from "@/lib/contant/post";
import createSupbaseServerClient from "@/lib/supabase/client/server-client";
import { NextRequest, NextResponse } from "next/server";

export async function GET(request: NextRequest) {
  // parsing
  const { searchParams } = new URL(request.url);
  const page = Number(searchParams.get("page")) ?? 1;
  const size = Number(searchParams.get("size")) ?? 20;

  const supabase = await createSupbaseServerClient();
  const res = await supabase
    .from("post_comments")
    .select("*, author:users(*)")
    .order("created_at", {
      ascending: false,
    })
    .range((page - 1) * size, page * size - 1);

  // on error
  if (res.error) {
    return NextResponse.json({}, { status: 500 });
  }

  if (res.data == null) {
    return NextResponse.json({}, { status: 204 });
  }

  return NextResponse.json(
    { payload: res.data as PostCommentWithAuthor[] },
    { status: res.status, statusText: res.statusText }
  );
}

export async function POST(request: NextRequest) {
  // parsing
  const props: {
    id: string;
    content: string;
    post_id: string;
  } = await request.json();

  // upload
  const supabase = await createSupbaseServerClient();
  const res = await supabase.from("post_comments").insert({
    ...props,
  });

  // on error
  if (res.error) {
    return NextResponse.json({}, { status: 500 });
  }

  // on success
  return NextResponse.json(
    { payload: res.data },
    { status: res.status, statusText: res.statusText }
  );
}
