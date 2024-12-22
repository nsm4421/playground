import { Request, Response } from "express";
import bcrypt from "bcrypt";
import pool from "../../model/pool";
import handleError from "../../utils/error.util";
import {
  CustomError,
  ErrorResponse,
  SuccessResponse,
} from "../../model/response.model";

const SALT_ROUND = 10;

type Account = {
  id: string;
  email: string;
  password: string;
  username: string;
};

interface SignUpReqDto {
  email: string;
  password: string;
  username: string;
}

interface SignUpSuccessResponse {
  id: string;
  email: string;
  username: string;
}

export default async function onSignUp(
  req: Request,
  res: Response<SuccessResponse<SignUpSuccessResponse> | ErrorResponse>
) {
  try {
    const { email, password: rawPassword, username }: SignUpReqDto = req.body;
    console.table({ email, rawPassword, username });
    if (!email || !rawPassword || !username) {
      throw new CustomError({
        code: "INAVLID_PARAMETER",
        message: "invalid request",
      });
    }
    const hashedPassword = await bcrypt.hash(rawPassword, SALT_ROUND);
    const saved = await pool.query(
      "INSERT INTO ACCOUNTS (EMAIL, PASSWORD, USERNAME) VALUES ($1,$2,$3) RETURNING *",
      [email, hashedPassword, username]
    );
    const { password, ...payload }: Account = saved.rows[0];
    res.status(201).json({
      message: "sign up success",
      payload,
    });
  } catch (error: any) {
    handleError({ error, res });
  }
}
