import prisma from "@/lib/prisma";
import { failure, success } from "@/util/custom-api-resopnse";
import * as bcrypt from "bcrypt";

interface RequestBody {
  email: string;
  password: string;
}

const findByEmailWithProfile = async (email: string) => {
  return await prisma.user.findFirst({
    where: {
      email,
    },
    include: {
      profile: true,
    },
  });
};

export async function POST(req: Request) {
  try {
    const body: RequestBody = await req.json();
    const user = await findByEmailWithProfile(body.email);
    if (!user) {
      return failure({ message: `Email ${body.email} doesn't exist` });
    }
    if (!(await bcrypt.compare(body.password, user.password))) {
      return failure({ message: "Password is not matched" });
    }
    return success({
      message: "Success to login",
      data: {
        name: user.profile?.name ?? "UnKnown",
        email: user.email,
        role: user.role,
      },
    });
  } catch (err) {
    return failure({message: "Fail to login since server error"})
  }
}
