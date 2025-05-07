import { NextResponse } from "next/server";

export const apiSuccess = (props: { message?: string; data?: any }) => {
  return NextResponse.json(
    { data: props.data },
    {
      status: 200,
      statusText: props.message ?? "success",
    }
  );
};

export enum CustomErrorType {
  UNAUTHORIZED,
  INVALID_PARAMETER,
  ENTITY_NOT_FOUND,
  DUPLICATED_ENTITY,
  CONFLICT,
  DB_ERROR,
  SERVER_ERROR,
}

export const apiError = (
  customError?: CustomErrorType,
  message?: string,
  data?: any
) => {
  let config;
  switch (customError) {
    case CustomErrorType.UNAUTHORIZED:
      config = {
        status: 403,
        statusText: message ?? "unauthorized access",
      };
    case CustomErrorType.INVALID_PARAMETER:
      config = {
        status: 403,
        statusText: message ?? "parameter is invalid",
      };
    case CustomErrorType.ENTITY_NOT_FOUND:
      config = {
        status: 404,
        statusText: message ?? "not found",
      };
    case CustomErrorType.CONFLICT:
      config = {
        status: 409,
        statusText: message ?? "conflict",
      };
    case CustomErrorType.DB_ERROR:
      config = {
        status: 409,
        statusText: message ?? "DB error",
      };
    default:
      config = {
        status: 500,
        statusText: message ?? "server error",
      };
  }
  return NextResponse.json(data ?? null, { ...config });
};
