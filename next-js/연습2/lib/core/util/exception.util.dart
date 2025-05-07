import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constant/error_code.dart';

class CustomException implements Exception {
  final ErrorCode? _errorCode;
  final String? _message;
  final String? _description;

  CustomException({ErrorCode? errorCode, String? message, String? description})
      : _errorCode = errorCode,
        _message = message,
        _description = description;

  ErrorCode get code => _errorCode ?? ErrorCode.unknown;

  String get message => _message ?? ErrorCode.unknown.name;

  String get description => _description ?? message;

  static CustomException from(dynamic error,
      {ErrorCode? errorCode,
      String? message,
      String? description,
      Logger? logger}) {
    if (logger != null) {
      logger.e(error);
    }
    String? description;
    if (error is AuthException) {
      return CustomException(
          errorCode: errorCode ?? ErrorCode.postgres,
          message: message ?? error.message,
          description: error.message);
    } else if (error is PostgrestException) {
      return CustomException(
          errorCode: errorCode ?? ErrorCode.postgres,
          message: message ?? error.message,
          description: error.hint);
    } else if (error is StorageException) {
      return CustomException(
          errorCode: errorCode ?? ErrorCode.bucket,
          message: message ?? error.message,
          description: error.error);
    }
    return CustomException(
        errorCode: ErrorCode.unknown,
        message: message,
        description: description);
  }
}
