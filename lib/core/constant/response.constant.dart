enum Status {
  initial,
  loading,
  success,
  error;
}

enum ResponseType {
  ok(isSuccess: true, code: 200, description: "success"),
  badRequest(
      isSuccess: false, code: 400, description: "bad request"),
  internalError(
      isSuccess: false, code: 500, description: "internal server error");

  final bool isSuccess;
  final int code;
  final String description;

  const ResponseType(
      {required this.isSuccess, required this.code, required this.description});
}