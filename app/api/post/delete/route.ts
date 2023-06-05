import { getLoginUserEmail } from "@/util/auth-util";
import { connectDB } from "@/util/database";
import { ObjectId } from "mongodb";
import { NextRequest, NextResponse } from "next/server";

/// Delete post
export async function POST(req: NextRequest) {
  try {
    // check user logined or not
    const email = await getLoginUserEmail();
    if (!email) {
      return NextResponse.json({
        success: false,
        message: "can't get login user's email",
      });
    }

    // check id
    const input = await req.json();
    if (!input._id) {
      return NextResponse.json({
        success: false,
        message: "id is not valid",
      });
    }

    // check post exist or not
    const db = (await connectDB).db(process.env.DB_NAME);
    const post = await db.collection("post").findOne({ _id: new ObjectId(input._id) });
    if (!post) {
      return NextResponse.json({
        success: false,
        message: "post not found",
      });
    }

    // check author and login user are equal
    if (post.email !== email) {
      return NextResponse.json({
        success: false,
        message: "only author can delete post",
      });
    }

    // delete data
    const data = await db
      .collection("post")
      .deleteOne({ _id: new ObjectId(input._id) });

    if (data.deletedCount !== 1) {
      return NextResponse.json({
        success: false,
        message: "fail to delete post, return delete count",
        data: data.deletedCount,
      });
    }

    // on success
    return NextResponse.json({
      success: true,
      message: "success to delete post, return delete count",
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
