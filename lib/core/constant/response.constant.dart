part of '../export.core.dart';

enum ErrorType {
  server,
  client;
}

enum StatusCode {
  success("SUCCESS", null),
  invalidParams("INAVLID_PARAMETER", ErrorType.server),
  duplicated("DUPLICATED_ENTITY", ErrorType.server),
  notFound("NOT_FOUND", ErrorType.server),
  invalidCrendential("INVALID_CREDENTIAL", ErrorType.server),
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

  factory ErrorResponse.from(Object error) {
    if (error is DioException) {
      // On Dio Exception
      final errorData = error.response?.data;
      final isParsable =
          errorData is Map<String, dynamic> && errorData.containsKey('code');
      final errorCode = isParsable
          ? (StatusCode.values
                  .where((item) => item.name == errorData['code'])
                  .firstOrNull ??
              StatusCode.internalServerError)
          : StatusCode.internalServerError;
      return ErrorResponse(
          code: errorCode,
          message: error.message ?? 'server error occurs',
          description: error.error.toString());
    } else if (error is Exception) {
      // On Client exception
      return ErrorResponse(
          code: StatusCode.clientError,
          message: 'exception occurs',
          description: error.toString());
    } else {
      // On Client Error
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
