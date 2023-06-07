import { connectDB } from "@/util/database";
import { getServerSession } from "next-auth";
import { NextRequest, NextResponse } from "next/server";
import { authOptions } from "../../[...nextauth]/route";
import { ObjectId } from "mongodb";

// Get nickname
export async function GET() {
  try {
    // check logined or not
    const session = await getServerSession(authOptions)
    if (!session?.user.id) {
      return NextResponse.json({
        success: false,
        message: "login first",
      });
    }

    // find nickname by email
    const db = (await connectDB).db(process.env.DB_NAME);

    // get user id
    const user = await db.collection("users").findOne({ _id : new ObjectId(session.user.id) });

    if (!user || !user.email) {
      return NextResponse.json({
        success: false,
        message: "user id is not founded",
      });
    }

    const data = await db.collection("nickname").findOne({ userId:user._id });

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
    const session = await getServerSession(authOptions)
    if (!session?.user.id) {
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
      .insertOne({ userId: session.user.id, email:session.user.email, nickname: input.nickname});

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
