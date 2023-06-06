import { connectDB } from "@/util/database";
import { RegisterRequest } from "@/util/model";
import bcrypt from "bcrypt";
import { NextRequest, NextResponse } from "next/server";

// Register
export async function POST(req: NextRequest) {
  try {
    // check input
    const input: RegisterRequest = await req.json();
    if (!input.email || !input.password) {
      return NextResponse.json({
        success: false,
        message: "email or password is blank",
      });
    }

    // check registered or not
    const db = (await connectDB).db(process.env.DB_NAME);
    const user = await db
      .collection("users")
      .findOne({ email: input.email });
    if (user) {
      return NextResponse.json({
        success: false,
        message: "already registered email",
      });
    }

    // insert data
    const hashed = await bcrypt.hash(input.password, 10);
    const data = await db
      .collection("users")
      .insertOne({ ...input, password: hashed, role:"USER" });

    if (!data.insertedId) {
      return NextResponse.json({
        success: false,
        message: "inserting data in DB fails",
      });
    }

    // on success
    return NextResponse.json({
      success: true,
      message: "success to register, return inserted id",
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
