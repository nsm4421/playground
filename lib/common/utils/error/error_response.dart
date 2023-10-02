class ErrorResponse {
  final String? status;
  final String? code;
  final String? message;

  const ErrorResponse({
    this.status = 'ERROR',
    this.code = '500',
    this.message = 'ERROR',
  });
}
