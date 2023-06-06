import { getLoginUserEmail } from "@/util/auth-util";
import { connectDB } from "@/util/database";
import { NextRequest, NextResponse } from "next/server";

// Get nickname
export async function GET() {
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

    // get user id
    const user = await db.collection("users").findOne({ email });

    if (!user?._id) {
      return NextResponse.json({
        success: false,
        message: "user id is not founded",
      });
    }

    const data = await db.collection("nickname").findOne({ email });

    // on success
    if (!data?.nickname) {
      return NextResponse.json({
        success: true,
        message: "nickname not exist",
        data: null,
      });
    }
    return NextResponse.json({
      success: true,
      message: "nickname exists",
      data: data.nickname,
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

    // check nickname is duplicated or not
    if (await db.collection("users").findOne({ email })) {
      return NextResponse.json({
        success: false,
        message: "nickname is duplicated",
      });
    }

    // get user id
    const user = await db.collection("users").findOne({ email });
    if (!user?._id) {
      return NextResponse.json({
        success: false,
        message: "user id is not founded",
      });
    }

    // save nickname
    const data = await db
      .collection("nickname")
      .insertOne({ userId: user._id, nickname: input.nickname, email});

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
