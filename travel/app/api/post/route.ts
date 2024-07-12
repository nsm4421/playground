import { ApiErrorType, CustomApiError } from "@/lib/contant/api-error";
import { PostWithAuthor } from "@/lib/contant/post";
import createSupbaseServerClient from "@/lib/supabase/client/server-client";
import { NextRequest, NextResponse } from "next/server";

/// 포스팅 목록 조회
export async function GET(request: NextRequest) {
  try {
    // parsing
    const { searchParams } = new URL(request.url);
    const page = Number(searchParams.get("page")) ?? 1;
    const size = Number(searchParams.get("size")) ?? 20;

    // db requst
    const supabase = await createSupbaseServerClient();
    const res = await supabase
      .from("posts")
      .select("*, author:users(*)")
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

    // on success
    return NextResponse.json(
      { payload: (res.data ?? []) as PostWithAuthor[] },
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

/// 포스팅 신규작성
export async function POST(request: NextRequest) {
  try {
    // parsing
    const props: {
      id: string;
      content: string;
      hashtags: string[];
      images: string[];
    } = await request.json();

    // db request
    const supabase = await createSupbaseServerClient();
    const res = await supabase.from("posts").insert({
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
      { payload: res.data },
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

/// 포스팅 수정
export async function PUT(request: NextRequest) {
  try {
    // parsing
    const props: {
      id: string;
      content: string;
      hashtags: string[];
      images: string[];
    } = await request.json();

    // db request
    // request요청을 보낸 사람과 작성자가 동일한지는 RLS에 의해 자동으로 체크되므로, 따로 코드작성이 불필요
    const supabase = await createSupbaseServerClient();
    const res = await supabase
      .from("posts")
      .upsert({
        ...props,
      })
      .eq("id", props.id);

    // on error
    if (res.error) {
      throw new CustomApiError({
        type: ApiErrorType.POSTGREST_ERROR,
        message: res.error.message,
      });
    }

    // on success
    return NextResponse.json(
      { payload: res.data },
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

/// 포스팅 삭제
export async function DELETE(request: NextRequest) {
  try {
    // parsing
    const { searchParams } = new URL(request.url);
    const post_id = searchParams.get("post_id");
    if (post_id == null) {
      throw new CustomApiError({
        type: ApiErrorType.BAD_REQUEST,
        message: "post id is null",
      });
    }

    // db request
    const supabase = await createSupbaseServerClient();
    const res = await supabase.from("posts").delete().eq("id", post_id);

    // on error
    if (res.error) {
      throw new CustomApiError({
        type: ApiErrorType.POSTGREST_ERROR,
        message: res.error.message,
      });
    }

    // on success
    return NextResponse.json(
      { payload: res.data },
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
