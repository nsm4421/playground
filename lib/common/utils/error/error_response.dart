class ErrorResponse {
  final String? status;
  final String? code;
  final String? messsage;

  ErrorResponse({
    this.status = 'ERROR',
    this.code = '500',
    this.messsage = 'ERROR',
  });
}
