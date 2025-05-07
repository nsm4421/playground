enum ResponseStatus {
  success(isError: false, code: 200, description: 'success'),
  noContent(
      isError: false,
      code: 204,
      description: 'request success, but data is null'),
  error(isError: true, code: 500, description: 'error');

  final bool isError;
  final int code;
  final String description;

  const ResponseStatus(
      {required this.isError, required this.code, required this.description});
}
