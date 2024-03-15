enum Status {
  initial,
  loading,
  success,
  error;
}

enum ResponseType {
  ok(isSuccess: true, code: 200, description: "success"),
  internalError(
      isSuccess: false, code: 500, description: "internal server error");

  final bool isSuccess;
  final int code;
  final String description;

  const ResponseType(
      {required this.isSuccess, required this.code, required this.description});
}