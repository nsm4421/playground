import { Response } from "express";
import { CustomError, ErrorResponse } from "../model/response.model";

interface Props {
  error: any;
  errorMessage?: string;
  res: Response<ErrorResponse>;
}

export default function handleError({ error, errorMessage, res }: Props) {
  if (error instanceof CustomError) {
    // custom error
    switch (error.code) {
      case "INAVLID_PARAMETER":
      case "INVALID_CREDENTIAL":
        res.status(400).json({
          errorCode: error.code,
          message: errorMessage ?? "entity is duplicated",
        });
        return;
      case "NOT_FOUND":
        res.status(404).json({
          errorCode: error.code,
          message: errorMessage ?? "entity not found",
        });
        return;

      default:
        res.status(500).json({
          errorCode: "INTERNAL_SERVER_ERROR",
          message: errorMessage ?? "internal server error",
        });
        return;
    }
  } else if (error?.code) {
    // database error
    switch (error.code) {
      case "23505": // not unique
        res.status(409).json({
          errorCode: "DUPLICATED_ENTITY",
          message: errorMessage ?? "entity is duplicated",
        });
        return;
      case "23502": // not null
        res.status(400).json({
          errorCode: "INAVLID_PARAMETER",
          message: errorMessage ?? "given null on not nullable field",
        });
        return;
    }
  }
  // unknown error
  res.status(500).json({
    errorCode: "INTERNAL_SERVER_ERROR",
    message: errorMessage ?? "internal server error",
  });
}
