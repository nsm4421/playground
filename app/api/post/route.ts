import { connectDB } from "@/util/database";
import { PostData } from "@/util/model";
import { ObjectId } from "mongodb";
import { NextRequest, NextResponse } from "next/server";

/// Get post by id
export async function GET(request: Request) {
  try {
    // check url
    const { searchParams } = new URL(request.url);
    const _id = searchParams.get("_id");
    let data: PostData | null = null;
    if (!(_id && typeof _id === "string")) {
      return NextResponse.json({
        success: false,
        message: "post id is not valid",
      });
    }

    // find by id
    const db = (await connectDB).db(process.env.DB_NAME);
    data = await db
      .collection("post")
      .findOne({
        _id: new ObjectId(_id),
      })
      .then((doc) => {
        if (doc) return { ...doc, _id: String(doc._id) };
        return null;
      });

    // on success
    return NextResponse.json({
      success: true,
      message: "success",
      data,
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

/// Write post
export async function POST(req: NextRequest) {
  try {
    // check user input
    const input = await req.json();
    if (!input.title || !input.content) {
      return NextResponse.json({
        success: false,
        message: "title or content is blank",
      });
    }

    // insert data
    const db = (await connectDB).db(process.env.DB_NAME);
    const data = await db.collection("post").insertOne(input);

    // on success
    return NextResponse.json({
      success: true,
      message: "success to write post, return inserted id",
      data: data.insertedId,
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

/// Update post
export async function PUT(req: NextRequest) {
  try {
    // check user input
    const input = await req.json();
    if (!input._id) {
      return NextResponse.json({
        success: false,
        message: "post id is not given",
      });
    }
    if (!input.title || !input.content) {
      return NextResponse.json({
        success: false,
        message: "title or content is blank",
      });
    }

    // insert data
    const db = (await connectDB).db(process.env.DB_NAME);
    const data = await db
      .collection("post")
      .updateOne(
        { _id: new ObjectId(input._id) },
        { $set: { title: input.title, content: input.content } }
      );

    // on success
    return NextResponse.json({
      success: true,
      message: "success to update post, return updated id",
      data: data.upsertedId,
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
