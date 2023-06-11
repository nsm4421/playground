import { connectDB } from "@/util/database";
import { PostData } from "@/util/model";
import { ObjectId } from "mongodb";
import { getServerSession } from "next-auth";
import { NextRequest, NextResponse } from "next/server";
import { authOptions } from "../auth/[...nextauth]/route";
import { CustomErrorType, apiError, apiSuccess } from "@/util/api-response";

const findAllPost = async (props: { page: number; limit: number }) => {
  const db = (await connectDB).db(process.env.DB_NAME);
  const posts = await db
    .collection("post")
    .find()
    .sort({ createdAt: 1 })
    .skip((props.page - 1) * props.limit)
    .limit(props.limit)
    .toArray()
    .then((docs) =>
      docs.map((doc) => ({ ...doc, postId: String(doc._id) } as PostData))
    );
  const totalCount = await db.collection("post").countDocuments();
  // on success
  return apiSuccess({ data: { posts, totalCount } });
};

const findPostById = async (postId: string) => {
  // check post id
  if (!postId)
    return apiError(CustomErrorType.INVALID_PARAMETER, "post id in not valid");

  // find by id
  const db = (await connectDB).db(process.env.DB_NAME);
  const data: PostData | null = await db
    .collection("post")
    .findOne({
      _id: new ObjectId(postId),
    })
    .then((doc) => {
      if (doc) return { ...doc, postId: String(doc._id) };
      return null;
    });

  // post not found
  if (!data) return apiError(CustomErrorType.ENTITY_NOT_FOUND, "no post found");

  // on success
  return apiSuccess({ data });
};

/// Get post by id
export async function GET(req: Request) {
  try {
    // get param
    const { searchParams } = new URL(req.url);
    const postId = await searchParams.get("postId");
    const page = await searchParams.get("page");
    const limit = await searchParams.get("limit");
    // post id is given → find post by id
    // post id is not given  → find all
    if (postId) {
      return await findPostById(postId);
    } else {
      return await findAllPost({
        page: Number(page) ?? 1,
        limit: Number(limit) ?? 10,
      });
    }
  } catch (_) {
    // on failure
    return apiError();
  }
}

/// Write post
export async function POST(req: NextRequest) {
  try {
    // check user logined or not
    const session = await getServerSession(authOptions);
    const userId = session?.user.id;
    if (!userId) return apiError(CustomErrorType.UNAUTHORIZED);

    // check user input
    const input = await req.json();
    if (!input.title)
      return apiError(CustomErrorType.INVALID_PARAMETER, "title is not valid");
    if (!input.content)
      return apiError(
        CustomErrorType.INVALID_PARAMETER,
        "content is not valid"
      );

    // insert data
    const db = (await connectDB).db(process.env.DB_NAME);
    const data = await db.collection("post").insertOne({
      ...input,
      userId,
      createdAt: new Date(),
      updatedAt: new Date(),
    });

    // on success
    return apiSuccess({
      message: "success to write post, return inserted id",
      data: data.insertedId,
    });
  } catch (_) {
    // on failure
    return apiError();
  }
}

/// Update post
export async function PUT(req: NextRequest) {
  try {
    // check user logined or not
    const session = await getServerSession(authOptions);
    const userId = session?.user.id;
    if (!userId) return apiError(CustomErrorType.UNAUTHORIZED);

    // check user input
    const input = await req.json();
    if (!input.postId)
      return apiError(
        CustomErrorType.INVALID_PARAMETER,
        "post id is not valid"
      );
    if (!input.title)
      return apiError(CustomErrorType.INVALID_PARAMETER, "title is not valid");
    if (!input.content)
      return apiError(
        CustomErrorType.INVALID_PARAMETER,
        "content is not valid"
      );

    // check post exists
    const db = (await connectDB).db(process.env.DB_NAME);
    const post = await db
      .collection("post")
      .findOne({ _id: new ObjectId(input._id) });
    if (!post)
      return apiError(CustomErrorType.ENTITY_NOT_FOUND, "post not founded");

    // check author is equal to login user
    if (post.userId !== userId)
      return apiError(
        CustomErrorType.UNAUTHORIZED,
        "only author can update post"
      );

    // update data
    const data = await db.collection("post").updateOne(
      { _id: new ObjectId(input.postId) },
      {
        $set: {
          title: input.title,
          content: input.content,
          updatedAt: new Date(),
        },
      }
    );

    // on success
    return apiSuccess({
      message: "success to update post, return updated id",
      data: data.upsertedId,
    });
  } catch (_) {
    // on failure
    return apiError();
  }
}

/// Delete post
export async function DELETE(req: NextRequest) {
  try {
    // check user logined or not
    const session = await getServerSession(authOptions);
    const userId = session?.user.id;
    if (!userId) return apiError(CustomErrorType.UNAUTHORIZED);

    // get param
    const { searchParams } = new URL(req.url);
    const postId = await searchParams.get("postId");
    if (!postId)
      return apiError(
        CustomErrorType.INVALID_PARAMETER,
        "post id is not valid"
      );

    // check post exist or not
    const db = (await connectDB).db(process.env.DB_NAME);
    const post = await db
      .collection("post")
      .findOne({ _id: new ObjectId(postId) });
    if (!post)
      return apiError(CustomErrorType.ENTITY_NOT_FOUND, "post not founded");

    // check author and login user are equal
    if (post.userId !== userId) {
      return NextResponse.json({
        success: false,
        message: "only author can delete post",
      });
    }

    // delete data
    const data = await db
      .collection("post")
      .deleteOne({ _id: new ObjectId(postId) });

    if (data.deletedCount !== 1) {
      return NextResponse.json({
        success: false,
        message: "fail to delete post, return delete count",
        data: data.deletedCount,
      });
    }

    // on success
    return apiSuccess({
      message: "success to delete post, return delete count",
      data: data.deletedCount,
    });
  } catch (_) {
    // on failure
    return apiError();
  }
}
