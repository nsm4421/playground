import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      logger.e(error.toString());
    }
    if (errorCode != null) {
      return CustomException(
          errorCode: errorCode, message: message ?? errorCode.name);
    } else if (error is AuthException) {
      // bad request
      return CustomException(
          errorCode: ErrorCode.authError,
          message: message ?? ErrorCode.authError.name);
    } else if (error is ArgumentError) {
      // bad request
      return CustomException(
          errorCode: ErrorCode.invalidArgs,
          message: message ?? ErrorCode.invalidArgs.name);
    } else {
      // un known
      return CustomException(
          errorCode: ErrorCode.unKnownError,
          message: message ?? ErrorCode.unKnownError.name);
    }
  }
}
