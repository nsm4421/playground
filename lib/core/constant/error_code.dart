enum ErrorCode {
  auth(code: "auth", message: "auth error"),
  postgres(code: "postgres", message: "database error"),
  bucket(code: "bucket", message: "storage error"),
  unknown(code: "unknown", message: "unknown error occurs");

  final String code;
  final String message;

  const ErrorCode({required this.code, required this.message});
}
