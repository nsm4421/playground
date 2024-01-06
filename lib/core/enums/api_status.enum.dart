enum ApiStatus {
  success(isError: false, code: 200, description: 'success'),
  error(isError: true, code: 500, description: 'error');

  final bool isError;
  final int code;
  final String description;

  const ApiStatus(
      {required this.isError, required this.code, required this.description});
}
