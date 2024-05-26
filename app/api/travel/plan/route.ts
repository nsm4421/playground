import { ApiErrorType, CustomApiError } from "@/lib/contant/api-error";
import { CountryCode } from "@/lib/contant/map";
import createSupbaseServerClient from "@/lib/supabase/client/server-client";
import { NextRequest, NextResponse } from "next/server";

/// 여행계획 작성
export async function POST(request: NextRequest) {
  try {
    // parsing
    const props: {
      id: string;
      start_date: string;
      end_date: string;
      country_code: CountryCode;
      mapbox_id: string;
      coordinate: number[];
      place_name: string;
      title: string;
      hashtags: string[];
      content: string;
    } = await request.json();
    console.debug(props);

    // db request
    const supabase = await createSupbaseServerClient();
    const res = await supabase
      .from("travel_plans")
      .insert({ ...props, coordinate: JSON.stringify(props.coordinate) });

    // on error
    if (res.error) {
      throw new CustomApiError({
        type: ApiErrorType.POSTGREST_ERROR,
        message: res.error.message,
      });
    }

    // on success
    return NextResponse.json(res.data, {
      status: res.status,
      statusText: res.statusText,
    });
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error },
      { status: error instanceof CustomApiError ? error.code : 500 }
    );
  }
}

/// 여행계획 수정
export async function PUT(request: NextRequest) {
  try {
    // parsing
    const props: {
      id: string;
      title: string;
      hashtags: string[];
      content: string;
    } = await request.json();
    console.debug(props);

    // db request
    const supabase = await createSupbaseServerClient();
    const res = await supabase
      .from("travel_plans")
      .update({ ...props })
      .eq("id", props.id);

    // on error
    if (res.error) {
      throw new CustomApiError({
        type: ApiErrorType.POSTGREST_ERROR,
        message: res.error.message,
      });
    }

    // on success
    return NextResponse.json(res.data, {
      status: res.status,
      statusText: res.statusText,
    });
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error },
      { status: error instanceof CustomApiError ? error.code : 500 }
    );
  }
}

/// 여행계획 수정
export async function DELETE(request: NextRequest) {
  try {
    // parsing
    const { searchParams } = new URL(request.url);
    const plan_id = searchParams.get("plan_id");
    console.debug(`plan_id : ${plan_id}`);
    if (plan_id == null) {
      throw new CustomApiError({
        type: ApiErrorType.BAD_REQUEST,
        message: "plan id is null",
      });
    }

    // db request
    const supabase = await createSupbaseServerClient();
    const res = await supabase.from("travel_plans").delete().eq("id", plan_id);

    // on error
    if (res.error) {
      throw new CustomApiError({
        type: ApiErrorType.POSTGREST_ERROR,
        message: res.error.message,
      });
    }

    // on success
    return NextResponse.json(res.data, {
      status: res.status,
      statusText: res.statusText,
    });
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error },
      { status: error instanceof CustomApiError ? error.code : 500 }
    );
  }
}
