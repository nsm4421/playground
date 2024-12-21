import { Request, Response } from "express";
import bcrypt from "bcrypt";
import pool from "../model/pool";
import jwt from "jsonwebtoken";

const SALT_ROUND = 10;
const JWT_SECRET = process.env.JWT_SECRET || "1221";
const EXPIRES_IN = "24h";

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

interface SignInReqDto {
  email: string;
  password: string;
}

export const onSignUp = async (req: Request, res: Response) => {
  try {
    const { email, password: rawPassword, username }: SignUpReqDto = req.body;
    console.table({ email, rawPassword, username });
    if (!email || !rawPassword || !username) {
      res.status(400).json({ message: "invalid request" });
      return;
    }
    const hashedPassword = await bcrypt.hash(rawPassword, SALT_ROUND);
    const saved = await pool.query(
      "INSERT INTO ACCOUNTS (EMAIL, PASSWORD, USERNAME) VALUES ($1,$2,$3) RETURNING *",
      [email, hashedPassword, username]
    );
    const { password, ...payload }: Account = saved.rows[0];
    res.status(201).json({
      message: "sign up success",
      account: payload,
    });
  } catch (error: any) {
    console.error(error);
    if (error.code) {
      switch (error.code) {
        case "23505": // not unique
          res.status(409).json({ message: "email or username is duplicated" });
          return;
        case "23502": // not null
          res.status(400).json({ message: "missing required fields" });
          return;
        default:
          res.status(500).json({ message: "database error" });
          return;
      }
    }
    res.status(500).json({ message: "internal server error" });
  }
};

export const onSignIn = async (req: Request, res: Response) => {
  try {
    const { email, password }: SignInReqDto = req.body;
    const fetched = await pool.query("SELECT * FROM ACCOUNTS WHERE EMAIL=$1", [
      email,
    ]);
    if (!fetched || fetched.rowCount === 0) {
      res.status(404).json({ message: "user not found" });
      return;
    }
    const user: Account = fetched.rows[0];
    const isPasswordMatch = await bcrypt.compare(password, user.password);
    if (!isPasswordMatch) {
      res.status(400).json({ message: "invalid credential" });
      return;
    }
    const token = jwt.sign({ uid: user.id }, JWT_SECRET, {
      expiresIn: EXPIRES_IN,
    });
    res.status(200).json({ message: "sign in success", token });
  } catch (error: any) {
    console.error(error);
    if (error.code) {
      res.status(500).json({ message: "database error" });
      return;
    }
    res.status(500).json({ message: "internal server error" });
  }
};
