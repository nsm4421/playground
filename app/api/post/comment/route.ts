import { connectDB } from "@/util/database";
import { getServerSession } from "next-auth";
import { NextRequest, NextResponse } from "next/server";
import { authOptions } from "../../auth/[...nextauth]/route";
import { ObjectId } from "mongodb";

/// Get comments by id
export async function GET(request: Request) {
  try {
    // check url
    const { searchParams } = new URL(request.url);
    const postId = searchParams.get("postId");
    if (!postId) {
      return NextResponse.json({
        success: false,
        message: "success",
      });
    }

    // find comment by post id
    const db = (await connectDB).db(process.env.DB_NAME);
    const comments = await db
      .collection("comment")
      .aggregate([
        {
          $lookup: {
            // Join by userId with nickname collection
            from: "nickname",
            localField: "userId",
            foreignField: "userId",
            // Call forien collection(nickname) fields "as" foriegnColumns
            as: "foreignColumns",
          },
        },
        { $unwind: "$foreignColumns" },
        {
          $project: {
            _id: 1,
            userId: 1,
            postId: 1,
            content: 1,
            createdAt: 1,
            updatedAt: 1,
            nickname: "$foreignColumns.nickname",
          },
        },
      ])
      .toArray();

    // on success
    return NextResponse.json({
      success: true,
      message: "success",
      data: comments,
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
    if (!input.content || !input.postId) {
      return NextResponse.json({
        success: false,
        message: "content or post id is blank",
      });
    }

    // insert data
    const db = (await connectDB).db(process.env.DB_NAME);
    const data = await db.collection("comment").insertOne({
      ...input,
      userId: session.user.id,
      createdAt: new Date(),
      updatedAt: new Date(),
    });

    // on success
    return NextResponse.json({
      success: true,
      message: "success to write comment, return inserted id",
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

/// Modifty comment
export async function PUT(req: NextRequest) {
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
    if (!input.content || !input.commentId) {
      return NextResponse.json({
        success: false,
        message: "content or comment id is blank",
      });
    }

    // check logined user and author are equal
    const db = (await connectDB).db(process.env.DB_NAME);
    const comment = await db
      .collection("comment")
      .findOne({ _id: new ObjectId(input.commentId) });
    if (comment?.userId !== session.user.id) {
      return NextResponse.json({
        success: false,
        message: "only author can update comment",
      });
    }

    // insert data
    const data = await db
      .collection("comment")
      .updateOne(
        { _id: new ObjectId(input.commentId) },
        { $set: { content: input.content, updatedAt: new Date() } }
      );

    // on success
    return NextResponse.json({
      success: true,
      message: "success to update comment, return updated id",
      data: data.upsertedId,
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
