import 'package:logger/logger.dart';

import '../constant/error_code.dart';

class CustomException implements Exception {
  final ErrorCode? _errorCode;
  final String? _message;

  CustomException({ErrorCode? errorCode, String? message})
      : _errorCode = errorCode,
        _message = message;

  ErrorCode get code => _errorCode ?? ErrorCode.unKnownError;

  String get message => _message ?? ErrorCode.unKnownError.name;

  static CustomException from(dynamic error,
      {String? message, ErrorCode? errorCode, Logger? logger}) {
    if (logger != null) {
      logger.e(error);
    }
    return CustomException(
        errorCode: errorCode ?? ErrorCode.unKnownError,
        message: message ?? errorCode?.name ?? ErrorCode.unKnownError.name);
  }
}
