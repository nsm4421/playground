enum ErrorCode {
  internalError("internal error"),
  dioError("dio error"),
  permissionDenied("permission denied"),
  unKnownError("un known error"),
  unAuthorized("un authorized"),
  postgresError("exception occurs on postgres database"),
  hiveError("exception occurs on local database"),
  storageError("exception occurs on storage");

  final String description;

  const ErrorCode(this.description);
}

class Failure {
  final ErrorCode code;
  final String? message;

  Failure({required this.code, this.message});
}
