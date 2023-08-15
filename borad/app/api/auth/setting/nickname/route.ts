import { connectDB } from "@/util/database";
import { getServerSession } from "next-auth";
import { NextRequest } from "next/server";
import { authOptions } from "../../[...nextauth]/route";
import { ObjectId } from "mongodb";
import { apiSuccess, apiError, CustomErrorType } from "@/util/api-response";

/// Get nickname
export async function GET() {
  try {
    // check logined or not
    const session = await getServerSession(authOptions);
    if (!session?.user.id) return apiError(CustomErrorType.UNAUTHORIZED);
    const userId = new ObjectId(session.user.id)

    // find nickname by email
    const db = (await connectDB).db(process.env.DB_NAME);

    // get user id
    const user = await db
      .collection("users")
      .findOne({ _id: userId });
    if (!user || !user.email)
      return apiError(
        CustomErrorType.ENTITY_NOT_FOUND,
        "user id is not founded"
      );

    // on success
    const data = await db.collection("nickname").findOne({ userId: session.user.id });
    return apiSuccess({
      message: "success to set nickname",
      data: data?.nickname,
    });
  } catch (_) {
    // on failure
    return apiError();
  }
}

/// Set nickname
export async function POST(req: NextRequest) {
  try {
    // check logined or not
    const session = await getServerSession(authOptions);
    if (!session?.user.id) return apiError(CustomErrorType.UNAUTHORIZED);

    // check input
    const { nickname } = await req.json();
    if (!nickname)
      return apiError(
        CustomErrorType.INVALID_PARAMETER,
        "nickname is not given"
      );

    // check nickname duplicated or not
    const db = (await connectDB).db(process.env.DB_NAME);
    if (await db.collection("nickname").findOne({ nickname }))
      return apiError(
        CustomErrorType.DUPLICATED_ENTITY,
        "nickname is duplicated"
      );

    // save nickname
    const data = await db
      .collection("nickname")
      .insertOne({
        userId: session.user.id,
        email: session.user.email,
        nickname,
      });

    // on success
    return apiSuccess({
      message: "nickname is saved, return inserted id",
      data: data.insertedId,
    });
  } catch (_) {
    // on failure
    return apiError();
  }
}
