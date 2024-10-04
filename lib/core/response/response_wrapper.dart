import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/core/response/custom_exception.dart';

import '../constant/constant.dart';

abstract class ResponseWrapper<T> {
  bool get ok;

  T? get data;
}

class ResponseSuccess<T> extends ResponseWrapper<T> {
  final T? _data;

  ResponseSuccess(this._data);

  @override
  bool get ok => true;

  @override
  T? get data => _data;

  factory ResponseSuccess.from(T? data) {
    return ResponseSuccess<T>(data);
  }
}

class ResponseError<T> extends ResponseWrapper<T> {
  final CustomException exception;
  final String errorMessage;

  ResponseError(
      {required this.exception, this.errorMessage = 'exception occurs'});

  @override
  bool get ok => false;

  @override
  T? get data => null;

  factory ResponseError.from(Exception? exception,
      {ErrorCode? errorCode, String? errorMessage}) {
    // 에러코드가 주어진 경우
    if (errorCode != null) {
      return ResponseError<T>(
          exception: CustomException(errorCode,
              message: errorMessage ?? errorCode.description));
    }
    // 에러코드가 주어지지 않은 경우
    ErrorCode $errorCode = errorCode ?? ErrorCode.unknownError;
    if (exception is AuthException) {
      $errorCode = ErrorCode.auth;
    } else if (exception is StorageException) {
      $errorCode = ErrorCode.storage;
    } else if (exception is PostgrestException) {
      $errorCode = ErrorCode.db;
    }
    return ResponseError<T>(
        exception: CustomException($errorCode,
            message: errorMessage ?? $errorCode.description));
  }
}
