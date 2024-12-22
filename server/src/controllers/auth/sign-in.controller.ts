import { Request, Response } from "express";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import pool from "../../model/pool";
import handleError from "../../utils/error.util";
import {
  CustomError,
  ErrorResponse,
  SuccessResponse,
} from "../../model/response.model";

const JWT_SECRET = process.env.JWT_SECRET || "1221";
const EXPIRES_IN = "24h";

type Account = {
  id: string;
  email: string;
  password: string;
  username: string;
};

interface SignInReqDto {
  email: string;
  password: string;
}

interface SignInSuccessResponse {
  id: string;
  email: string;
  username: string;
  token: string;
}

export default async function onSignIn(
  req: Request,
  res: Response<SuccessResponse<SignInSuccessResponse> | ErrorResponse>
) {
  try {
    const { email, password }: SignInReqDto = req.body;
    const user: Account = await pool
      .query("SELECT * FROM ACCOUNTS WHERE EMAIL=$1", [email])
      .then((res) => {
        if (!res || res.rowCount === 0) {
          throw new CustomError({
            code: "NOT_FOUND",
            message: "user not found",
          });
        }
        return res.rows[0];
      });
    const isPasswordMatch = await bcrypt.compare(password, user.password);
    if (!isPasswordMatch) {
      throw new CustomError({
        code: "INVALID_CREDENTIAL",
        message: "invalid crendtial",
      });
    }
    const token = jwt.sign({ uid: user.id }, JWT_SECRET, {
      expiresIn: EXPIRES_IN,
    });
    res.status(200).json({
      message: "sign in success",
      payload: {
        id: user.id,
        email: user.email,
        username: user.username,
        token,
      },
    });
  } catch (error: any) {
    handleError(error);
  }
}
