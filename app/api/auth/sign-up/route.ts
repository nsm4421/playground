import serverClient from "@/lib/supabase/server-client";
import { NextRequest, NextResponse } from "next/server";

type Body = {
  email: string;
  password: string;
};

export async function POST(req: NextRequest) {
  try {
    const { email, password }: Body = await req.json();

    const client = serverClient();
    const {
      data: { user },
      error,
    } = await client.auth.signUp({
      email,
      password,
    });

    if (error) {
      return NextResponse.json({ error }, { status: 400, statusText: "FAIL" });
    }

    return NextResponse.json({ user }, { status: 200, statusText: "SUCCESS" });
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error },
      { status: 500, statusText: "SERVER_ERROR" }
    );
  }
}
