import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_response.freezed.dart';

@freezed
class ErrorResponse with _$ErrorResponse {
  const factory ErrorResponse({
    String? code,
    String? message,
  }) = _ErrorResponse;

  // TODO : 에러처리 구현하기
  static ErrorResponse from(Exception error) {
    return ErrorResponse(message: error.toString());
  }
}
