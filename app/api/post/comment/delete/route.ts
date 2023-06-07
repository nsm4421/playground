import { authOptions } from "@/app/api/auth/[...nextauth]/route";
import { connectDB } from "@/util/database";
import { ObjectId } from "mongodb";
import { getServerSession } from "next-auth";
import { NextRequest, NextResponse } from "next/server";

/// Delete comment
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
    // check id
    const input = await req.json();
    if (!input.commentId) {
      return NextResponse.json({
        success: false,
        message: "comment id is not given",
      });
    }

    // check post exist or not
    const db = (await connectDB).db(process.env.DB_NAME);
    const comment = await db.collection("comment").findOne({ _id: new ObjectId(input.commentId) });
    if (!comment) {
      return NextResponse.json({
        success: false,
        message: "comment not found",
      });
    }

    // check author and login user are equal
    if (comment.userId !== userId) {
      return NextResponse.json({
        success: false,
        message: "only author can delete comment",
      });
    }

    // delete data
    const data = await db
      .collection("comment")
      .deleteOne({ _id: new ObjectId(input.commentId) });

    if (data.deletedCount !== 1) {
      return NextResponse.json({
        success: false,
        message: "fail to delete comment, return delete count",
        data: data.deletedCount,
      });
    }

    // on success
    return NextResponse.json({
      success: true,
      message: "success to delete comment, return delete count",
      data: data.deletedCount,
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
