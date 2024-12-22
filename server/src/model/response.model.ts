export type SuccessResponse<T> = {
  message: string;
  payload: T;
};

export type ErrorCode =
  | "INAVLID_PARAMETER"
  | "DUPLICATED_ENTITY"
  | "NOT_FOUND"
  | "INVALID_CREDENTIAL"
  | "INTERNAL_SERVER_ERROR";

export type ErrorResponse = {
  errorCode: ErrorCode;
  message: string;
};

export class CustomError extends Error {
  code?: ErrorCode;
  constructor({ code, message }: { code?: ErrorCode; message?: string }) {
    super(message);
    this.code = code ?? "INTERNAL_SERVER_ERROR";
  }
}
