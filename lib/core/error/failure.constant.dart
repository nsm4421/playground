enum ErrorCode {
  unAuthorized("un authorized"),
  internalServerError("internal server error");

  final String name;

  const ErrorCode(this.name);
}

class Failure {
  final ErrorCode code;
  final String? message;

  Failure({required this.code, this.message});
}
