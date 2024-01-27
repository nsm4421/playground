import { connectDB } from "@/util/database";
import { getServerSession } from "next-auth";
import { NextRequest, NextResponse } from "next/server";
import { authOptions } from "../../auth/[...nextauth]/route";
import { ObjectId } from "mongodb";
import { CustomErrorType, apiError, apiSuccess } from "@/util/api-response";

/// Get comments by id
export async function GET(req: NextRequest) {
  try {
    // check url
    const { searchParams } = new URL(req.url);
    const postId = searchParams.get("postId");
    const page = Number(searchParams.get("page"));
    const limit = Number(searchParams.get("limit"));
    if (!postId || !page || !limit)
      return apiError(
        CustomErrorType.INVALID_PARAMETER,
        "post id or page or limit is not given"
      );

    // find comment by post id
    const db = (await connectDB).db(process.env.DB_NAME);
    const comments = await db
      .collection("comment")
      .find()
      // .aggregate([
      //   {
      //     $lookup: {
      //       // Join by userId with nickname collection
      //       from: "nickname",
      //       localField: "userId",
      //       foreignField: "userId",
      //       // Call forien collection(nickname) fields "as" foriegnColumns
      //       as: "foreignColumns",
      //     },
      //   },
      //   { $unwind: "$foreignColumns" },
      //   {
      //     $project: {
      //       _id: 1,
      //       userId: 1,
      //       postId: 1,
      //       content: 1,
      //       createdAt: 1,
      //       updatedAt: 1,
      //       nickname: "$foreignColumns.nickname",
      //     },
      //   },
      // ])
      .sort({ createdAt: -1 })
      .skip((page - 1) * limit)
      .limit(limit)
      .toArray();

    const totalCount = await db.collection("comment").countDocuments();
 
    // on success
    return apiSuccess({ data: {comments, totalCount} });
  } catch (_) {
     // on failure
    return apiError()
  }
}

/// Write comment
export async function POST(req: NextRequest) {
  try {
    // check user logined or not
    const session = await getServerSession(authOptions);
    const userId = session?.user.id;
    if (!userId) return apiError(CustomErrorType.UNAUTHORIZED);

    // check user input
    const input = await req.json();
    if (!input.postId) return apiError(CustomErrorType.INVALID_PARAMETER, "post id is not valid")
    if (!input.content) return apiError(CustomErrorType.INVALID_PARAMETER, "content is not valid")

    // insert data
    const db = (await connectDB).db(process.env.DB_NAME);
    const data = await db.collection("comment").insertOne({
      ...input,
      userId: session.user.id,
      createdAt: new Date(),
      updatedAt: new Date(),
    });

    // on success
    return apiSuccess({message: "success to write comment, return inserted id",data: data.insertedId,})
  } catch (_) {
    // on failure
    return apiError()
  }
}

/// Modifty comment
export async function PUT(req: NextRequest) {
  try {
    // check user logined or not
    const session = await getServerSession(authOptions);
    const userId = session?.user.id;
    if (!userId) return apiError(CustomErrorType.UNAUTHORIZED);

    // check user input
    const input = await req.json();
    if (!input.commentId)
      return apiError(
        CustomErrorType.INVALID_PARAMETER,
        "comment id is not valid"
      );
    if (!input.content)
      return apiError(
        CustomErrorType.INVALID_PARAMETER,
        "content is not valid"
      );

    // check logined user and author are equal
    const db = (await connectDB).db(process.env.DB_NAME);
    const comment = await db
      .collection("comment")
      .findOne({ _id: new ObjectId(input.commentId) });
    if (comment?.userId !== session.user.id)
      return apiError(
        CustomErrorType.UNAUTHORIZED,
        "only author can update comment"
      );

    // insert data
    const data = await db
      .collection("comment")
      .updateOne(
        { _id: new ObjectId(input.commentId) },
        { $set: { content: input.content, updatedAt: new Date() } }
      );

    // on success
    return apiSuccess({
      message: "success to update comment, return updated id",
      data: data.upsertedId,
    });
  } catch (_) {
    // on failure
    return apiError();
  }
}

export async function DELETE(req: NextRequest) {
  try {
    // check user logined or not
    const session = await getServerSession(authOptions);
    const userId = session?.user.id;
    if (!userId) return apiError(CustomErrorType.UNAUTHORIZED);

    // check url
    const { searchParams } = new URL(req.url);
    const commentId = searchParams.get("commentId");
    if (!commentId)
      return apiError(
        CustomErrorType.INVALID_PARAMETER,
        "comment id is not given"
      );

    // check post exist or not
    const db = (await connectDB).db(process.env.DB_NAME);
    const comment = await db
      .collection("comment")
      .findOne({ _id: new ObjectId(commentId) });
    if (!comment)
      return apiError(
        CustomErrorType.ENTITY_NOT_FOUND,
        "comment is not founded"
      );

    // check author and login user are equal
    if (comment.userId !== userId)
      return apiError(
        CustomErrorType.UNAUTHORIZED,
        "only author can delete comment"
      );

    // delete data
    const data = await db
      .collection("comment")
      .deleteOne({ _id: new ObjectId(commentId) });

    if (data.deletedCount !== 1)
      return apiError(CustomErrorType.DB_ERROR, "fail to delete comment on db");

    // on success
    return apiSuccess({
      message: "success to delete comment, return delete count",
      data: data.deletedCount,
    });
  } catch (_) {
    // on failure
    return apiError();
  }
}