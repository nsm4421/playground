import prisma from "@/lib/prisma";
import { failure, success } from "@/util/custom-api-resopnse";
import * as bcrypt from "bcrypt";

interface RequestBody {
  email: string;
  password: string;
}

const findByUserByEmail = async (email: string) => {
  return await prisma.user.findFirst({
    where: {
      email: email,
    },
  });
};

const createUser = async (props: { email: string; password: string }) => {
  const user = await prisma.user.create({
    data: {
      email: props.email,
      password: await bcrypt.hash(props.password, 10),
    },
  });
  const { password, ...data } = user;
  return data;
};

export async function POST(req: Request) {
  try {
    const body: RequestBody = await req.json();
    const exUser = await findByUserByEmail(body.email);
    // check email is duplicated or not
    if (exUser) {
      return failure({ message: `Email ${body.email} is already exist` });
    }
    return success({
      message: "Success to reigster",
      data: await createUser({ ...body }),
    });
  } catch (err) {
    return failure({ message: "Fail to login since server error" });
  }
}
