import { ApiErrorType, CustomApiError } from "@/lib/contant/api-error";
import { LikeReferenceType } from "@/lib/contant/likes";
import createSupbaseServerClient from "@/lib/supabase/client/server-client";
import { NextRequest, NextResponse } from "next/server";

/// 현재 좋아요 눌렀는지 여부
export async function GET(request: NextRequest) {
  try {
    // parsing
    const { searchParams } = new URL(request.url);
    const postId = searchParams.get("post_id");
    if (postId == null) {
      throw new CustomApiError({
        type: ApiErrorType.BAD_REQUEST,
        message: "post id is null",
      });
    }

    // get current user id
    const supabase = await createSupbaseServerClient();
    const currentUid = await supabase.auth
      .getUser()
      .then((res) => res.data.user?.id);
    if (currentUid == null) {
      throw new CustomApiError({
        type: ApiErrorType.UNAUTHORIZED,
        message: "current user id is null",
      });
    }

    // db request
    const res = await supabase
      .from("likes")
      .select("*", { count: "exact" })
      .eq("reference_id", postId)
      .eq("reference_type", "post" as LikeReferenceType)
      .eq("created_by", currentUid);

    // on error
    if (res.error) {
      throw new CustomApiError({
        type: ApiErrorType.POSTGREST_ERROR,
        message: res.error.message,
      });
    } else if (res.count == null) {
      throw new CustomApiError({
        type: ApiErrorType.POSTGREST_ERROR,
        message: "count query failed",
      });
    }

    // on success
    return NextResponse.json(
      { payload: res.count > 0 },
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

/// 좋아요 요청
export async function POST(request: NextRequest) {
  try {
    // parsing
    const { searchParams } = new URL(request.url);
    const postId = searchParams.get("post_id");
    if (postId == null) {
      throw new CustomApiError({
        type: ApiErrorType.POSTGREST_ERROR,
        message: "post id is null",
      });
    }

    // db request
    const supabase = await createSupbaseServerClient();
    const res = await supabase.from("likes").insert({
      reference_id: postId,
      reference_type: "post" as LikeReferenceType,
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

/// 좋아요 취소
export async function DELETE(request: NextRequest) {
  try {
    // parsing
    const { searchParams } = new URL(request.url);
    const postId = searchParams.get("post_id");

    if (postId == null) {
      throw new CustomApiError({
        type: ApiErrorType.BAD_REQUEST,
        message: "post id is null",
      });
    }

    // get current user id
    const supabase = await createSupbaseServerClient();
    const currentUid = await supabase.auth
      .getUser()
      .then((res) => res.data.user?.id);
    if (currentUid == null) {
      return NextResponse.json({ message: "un authorized" }, { status: 401 });
    }

    // db request
    const res = await supabase
      .from("likes")
      .delete()
      .eq("reference_id", postId)
      .eq("reference_type", "post" as LikeReferenceType)
      .eq("created_by", currentUid);

    // on error
    if (res.error) {
      throw new CustomApiError({
        type: ApiErrorType.POSTGREST_ERROR,
        message: res.error.message,
      });
    }

    // on success
    return NextResponse.json({ payload: res.data }, { status: 200 });
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error },
      { status: error instanceof CustomApiError ? error.code : 500 }
    );
  }
}
