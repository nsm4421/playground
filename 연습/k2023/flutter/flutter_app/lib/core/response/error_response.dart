import 'package:my_app/core/response/response_wrapper.dart';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_response.freezed.dart';

part 'error_response.g.dart';

@freezed
class ErrorResponse with _$ErrorResponse {
  const factory ErrorResponse(
      {@Default(200) int code,
      @Default('SUCCESS') String description,
      @Default('') String message}) = _ErrorResponse;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  static ErrorResponse fromResponseWrapper(ResponseWrapper res) =>
      ErrorResponse(
          code: res.status.code,
          description: res.status.description,
          message: res.message);

  static ErrorResponse fromError(Object error) =>
      ErrorResponse(code: 500, message: error.toString());
}
