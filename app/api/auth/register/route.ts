import { CustomErrorType, apiError, apiSuccess } from "@/util/api-response";
import { connectDB } from "@/util/database";
import { RegisterRequest } from "@/util/model";
import bcrypt from "bcrypt";
import { NextRequest } from "next/server";

// Register
export async function POST(req: NextRequest) {
  try {
    // check input
    const { email, password }: RegisterRequest = await req.json();
    if (!email)
      return apiError(CustomErrorType.INVALID_PARAMETER, "email is not given ");
    if (!password) return apiError(CustomErrorType.INVALID_PARAMETER,"password is not given");

    // check registered or not
    const db = (await connectDB).db(process.env.DB_NAME);
    const user = await db.collection("users").findOne({ email });
    if (user) return apiError(CustomErrorType.DUPLICATED_ENTITY,"email alrady exist");

    // insert data
    const hashed = await bcrypt.hash(password, 10);
    const data = await db
      .collection("users")
      .insertOne({ email, password: hashed, role: "USER" });
    if (!data.insertedId) return apiError(CustomErrorType.DB_ERROR, "inserting data in DB failed");

    // on success
    return apiSuccess({
      data: data.insertedId,
      message: "sign up success, return inserted id",
    });
  } catch {
    // on failure
    return apiError();
  }
}
