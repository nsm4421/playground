import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:hot_place/core/error/custom_exception.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExceptionUtil {
  static CustomException toCustomException(dynamic err,
      {String? message, ErrorCode? errorCode, Logger? logger}) {
    ErrorCode? $errorCode;
    String? $message;

    // 오류 코드가 주어진 경우
    if (errorCode != null) {
      $errorCode = errorCode;
    }
    // 오류 유형
    else if (err is DioError) {
      $errorCode = ErrorCode.dioError;
    } else if (err is HiveError) {
      $errorCode = ErrorCode.hiveError;
    } else if (err is PostgrestException) {
      $errorCode = ErrorCode.postgresError;
    } else if (err is StorageException) {
      $errorCode = ErrorCode.storageError;
    } else if (err is AuthException) {
      $errorCode = ErrorCode.unAuthorized;
    }
    // 알수 없는 오류
    else {
      $errorCode = ErrorCode.unKnownError;
    }

    if (logger != null) {
      logger.e(err);
    }

    return CustomException(
        code: $errorCode, message: $message ?? $errorCode.description);
  }
}
