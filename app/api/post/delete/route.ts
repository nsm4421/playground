import { connectDB } from "@/util/database";
import { ObjectId } from "mongodb";
import { NextRequest, NextResponse } from "next/server";

/// Delete post
export async function POST(req: NextRequest) {
  try {
    // check user input
    const input = await req.json();
    if (!input._id) {
      return NextResponse.json({
        success: false,
        message: "id is not valid",
      });
    }

    // insert data
    const db = (await connectDB).db(process.env.DB_NAME);
    const data = await db
      .collection("post")
      .deleteOne({ _id: new ObjectId(input._id) });

    // on success
    if (data.deletedCount === 1){
      return NextResponse.json({
        success: true,
        message: "success to delete post, return delete count",
        data: data.deletedCount,
      });
    }

    return NextResponse.json({
      success: false,
      message: "fail to delete post",
    });
    
  } catch (err) {
    // on failure
    console.error(err)
    return NextResponse.json({
      success: false,
      message: "server error",
    });
  }
}
