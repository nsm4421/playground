import { getLoginUserEmail } from "@/util/auth-util";
import { connectDB } from "@/util/database";
import { ObjectId } from "mongodb";
import { getServerSession } from "next-auth";
import { NextRequest, NextResponse } from "next/server";
import { authOptions } from "../../auth/[...nextauth]/route";

/// Write comment
export async function POST(req: NextRequest) {
  try {
    // check user logined or not
    const session = await getServerSession(authOptions);
    const userId = session?.user.id;
    if (!userId) {
      return NextResponse.json({
        success: false,
        message: "need to login",
      });
    }

    // check user input
    let input = await req.json();
    if (!input.title || !input.content) {
      return NextResponse.json({
        success: false,
        message: "title or content is blank",
      });
    }

    // insert data
    const db = (await connectDB).db(process.env.DB_NAME);
    const data = await db
      .collection("post")
      .insertOne({
        ...input,
        userId: session.user.id,
        createAt: new Date(),
        updatedAt: new Date(),
      });

    // on success
    return NextResponse.json({
      success: true,
      message: "success to write post, return inserted id",
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
