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
    if (errorCode != null) {
      // 에러 코드가 주어진 경우
      return ResponseError<T>(
          exception: CustomException(errorCode,
              message: errorMessage ?? errorCode.description));
    } else if (exception != null) {
      // exception이 주어진 경우
      return ResponseError<T>(
          exception: CustomException.from(exception),
          errorMessage: errorMessage ?? exception.toString());
    } else {
      // 그 외의 경우
      return ResponseError<T>(
          exception: CustomException(ErrorCode.unknownError),
          errorMessage: errorMessage ?? exception.toString());
    }
  }
}
