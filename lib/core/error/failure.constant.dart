enum ErrorCode {
  imageCompressFail("compressing image fails"),
  unAuthorized("un authorized"),
  serverRequestFail("request on server fails"),
  postgresError("exception occurs on postgres database"),
  hiveError("exception occurs on local database"),
  storageError("exception occurs on storage"),
  internalServerError("internal server error");

  final String name;

  const ErrorCode(this.name);
}

class Failure {
  final ErrorCode code;
  final String? message;

  Failure({required this.code, this.message});
}
