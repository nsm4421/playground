part of '../export.core.dart';

enum ErrorType {
  server,
  client;
}

enum StatusCode {
  success("SUCCESS", null),
  invalidParams("INVALID_PARAMETER", ErrorType.server),
  duplicated("DUPLICATED_ENTITY", ErrorType.server),
  notFound("NOT_FOUND", ErrorType.server),
  invalidCredential("INVALID_CREDENTIAL", ErrorType.server),
  internalServerError("INTERNAL_SERVER_ERROR", ErrorType.server),
  clientError("CLIENT_ERROR", ErrorType.client);

  final String name;
  final ErrorType? erroryType;

  const StatusCode(this.name, this.erroryType);
}

class SuccessResponse<T> {
  final StatusCode code = StatusCode.success;
  final String message;
  final T payload;

  SuccessResponse({this.message = 'success', required this.payload});
}

class ErrorResponse {
  final StatusCode code;
  final String message;
  final String? description;

  ErrorResponse({required this.code, this.message = 'error', this.description});

  factory ErrorResponse.from(Object error, {Logger? logger}) {
    if (error is DioException) {
      // On Dio Exception
      final errorData = error.response?.data;
      final parsedErrorCode =
          (errorData is Map<String, dynamic> && errorData.containsKey('code'))
              ? (StatusCode.values
                      .where((item) => item.name == errorData['code'])
                      .firstOrNull ??
                  StatusCode.internalServerError)
              : StatusCode.internalServerError;
      final parsedErrorMessage = (errorData is Map<String, dynamic> &&
              errorData.containsKey('message'))
          ? (errorData['message'])
          : error.message;
      if (logger != null) {
        logger.e(
            '[CustomError]code:$parsedErrorCode|message:$parsedErrorMessage');
      }
      return ErrorResponse(
          code: parsedErrorCode,
          message: parsedErrorMessage ?? error.message,
          description: error.message);
    } else if (error is Exception) {
      // On Client exception
      if (logger != null) {
        logger.e(error);
      }
      return ErrorResponse(
          code: StatusCode.clientError,
          message: 'exception occurs',
          description: error.toString());
    } else {
      // On Client Error
      if (logger != null) {
        logger.e(error);
      }
      return ErrorResponse(
          code: StatusCode.clientError,
          message: 'exception occurs',
          description: error.toString());
    }
  }

  ErrorResponse copyWith({String? message, String? description}) {
    return ErrorResponse(
        code: code,
        message: message ?? this.message,
        description: description ?? this.description);
  }
}
