import { connectDB } from "@/util/database";
import { NextResponse } from "next/server";

/// Get posts
export async function GET() {
  try {
    const db = (await connectDB).db(process.env.DB_NAME);
    const posts = await db.collection("post")
      .find()
      .toArray()
      .then((docs) => docs.map((doc) => ({ ...doc, _id: String(doc._id) })));
    // on success
    return NextResponse.json({
        success: true,
        message: "success to get posts",
        data:posts
      });
  } catch (err) {
    // on failure
    return NextResponse.json({
      success: false,
      message: "server error",
    });
  }
}
