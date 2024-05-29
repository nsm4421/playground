enum ErrorCode {
  internalServerError("INTERNAL_SERVER_ERROR"),
  authError("AUTHENTICATION_ERROR"),
  unKnownError("UNKNOWN_ERROR"),
  notGranted("NOT_GRANTED");

  final String name;

  const ErrorCode(this.name);
}
