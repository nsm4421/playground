import 'package:portfolio/core/util/exception.util.dart';

import 'error_code.dart';

class ResponseWrapper<T> {
  final bool ok;
  final T? data;
  final String? message;
  final ErrorCode? code;

  ResponseWrapper._({required this.ok, this.data, this.message, this.code});

  factory ResponseWrapper.success(T data) {
    return ResponseWrapper._(ok: true, data: data);
  }

  factory ResponseWrapper.error(String? message) {
    return ResponseWrapper._(ok: false, message: message ?? "ERROR");
  }

  factory ResponseWrapper.from(CustomException error, {String? message}) {
    return ResponseWrapper._(
        ok: false, code: error.code, message: message ?? error.message);
  }
}
