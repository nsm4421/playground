export enum ApiErrorType {
  NOT_FOUND,
  UNAUTHORIZED,
  BAD_REQUEST,
  POSTGREST_ERROR,
  INTERNAL_SERVER_ERROR,
}

export class CustomApiError extends Error {
  public code: number;

  constructor({ type, message }: { type: ApiErrorType; message?: string }) {
    switch (type) {
      case ApiErrorType.BAD_REQUEST:
        super(message ?? "Bad Request");
        this.name = "BadRequest";
        this.code = 400;
        break;
      case ApiErrorType.UNAUTHORIZED:
        super(message ?? "Not Authroized");
        this.name = "UnAuthorized";
        this.code = 401;
        break;
      case ApiErrorType.NOT_FOUND:
        super(message ?? "Not Found");
        this.name = "NotFound";
        this.code = 404;
        break;
      case ApiErrorType.POSTGREST_ERROR:
        super(message ?? "Error On Postgres Database");
        this.name = "PostgrestError";
        this.code = 502;
        break;
      default:
        super(message ?? "Internal Server Error");
        this.name = "InternalServerError";
        this.code = 500;
    }
  }
}
