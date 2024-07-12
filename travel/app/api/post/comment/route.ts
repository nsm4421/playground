import { ApiErrorType, CustomApiError } from "@/lib/contant/api-error";
import { PostCommentWithAuthor } from "@/lib/contant/post";
import createSupbaseServerClient from "@/lib/supabase/client/server-client";
import { NextRequest, NextResponse } from "next/server";

/// 댓글 목록 가져오기
export async function GET(request: NextRequest) {
  try {
    // parsing
    const { searchParams } = new URL(request.url);
    const post_id = searchParams.get("post_id");
    console.debug(`post_id : ${post_id}`);
    const page = Number(searchParams.get("page")) ?? 1;
    const size = Number(searchParams.get("size")) ?? 20;
    if (post_id == null) {
      throw new CustomApiError({
        type: ApiErrorType.BAD_REQUEST,
        message: "post id is null",
      });
    }

    // db request
    const supabase = await createSupbaseServerClient();
    const res = await supabase
      .from("post_comments")
      .select("*, author:users(*)")
      .eq("post_id", post_id)
      .order("created_at", {
        ascending: false,
      })
      .range((page - 1) * size, page * size - 1);

    // on error
    if (res.error) {
      throw new CustomApiError({
        type: ApiErrorType.POSTGREST_ERROR,
        message: res.error.message,
      });
    }

    // on sucess
    console.debug(res.data);
    return NextResponse.json(
      { payload: res.data as PostCommentWithAuthor[] },
      { status: res.status, statusText: res.statusText }
    );
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error },
      { status: error instanceof CustomApiError ? error.code : 500 }
    );
  }
}

/// 댓글 작성하기
export async function POST(request: NextRequest) {
  try {
    // parsing
    const props: {
      id: string;
      content: string;
      post_id: string;
    } = await request.json();
    console.debug(props);

    // db request
    const supabase = await createSupbaseServerClient();
    const res = await supabase.from("post_comments").insert({
      ...props,
    });

    // on error
    if (res.error) {
      throw new CustomApiError({
        type: ApiErrorType.POSTGREST_ERROR,
        message: res.error.message,
      });
    }

    // on success
    return NextResponse.json(
      { payload: res.data, message: "success" },
      { status: res.status, statusText: res.statusText }
    );
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error },
      { status: error instanceof CustomApiError ? error.code : 500 }
    );
  }
}
