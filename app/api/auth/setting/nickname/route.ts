import { getLoginUserEmail } from "@/util/auth-util";
import { connectDB } from "@/util/database";
import { NextRequest, NextResponse } from "next/server";

// Get nickname
export async function GET(req: NextRequest) {
  try {
    // check logined or not
    const email = await getLoginUserEmail();
    if (!email) {
      return NextResponse.json({
        success: false,
        message: "login first",
      });
    }

    // find nickname by email
    const db = (await connectDB).db(process.env.DB_NAME);
    const data = await db.collection("nickname").findOne({ email });

    // on success
    if (data?.nickname) {
      return NextResponse.json({
        success: true,
        message: "nickname exist",
        data: data.nickname,
      });
    }
    return NextResponse.json({
      success: true,
      message: "nickname not exists",
      data: null
    });
  } catch (err) {
    // on failure
    console.error(err);
    return NextResponse.json({
      success: false,
      message: "server error",
    });
  }
}

// Set nickname
export async function POST(req: NextRequest) {
  try {
    // check logined or not
    const email = await getLoginUserEmail();
    if (!email) {
      return NextResponse.json({
        success: false,
        message: "login first",
      });
    }

    // check input
    const input: { nickname: string } = await req.json();
    if (!input.nickname) {
      return NextResponse.json({
        success: false,
        message: "nickname is not given",
      });
    }

    // check nickname duplicated or not
    const db = (await connectDB).db(process.env.DB_NAME);
    if (await db.collection("nickname").findOne({ nickname: input.nickname })) {
      return NextResponse.json({
        success: false,
        message: "nickname is duplicated",
      });
    }

    // save nickname
    const data = await db
      .collection("nickname")
      .insertOne({ email, nickname: input.nickname });

    // on success
    return NextResponse.json({
      success: true,
      message: "nickname is saved, return inserted id",
      data: data.insertedId,
    });
  } catch (err) {
    // on failure
    console.error(err);
    return NextResponse.json({
      success: false,
      message: "server error",
    });
  }
}
