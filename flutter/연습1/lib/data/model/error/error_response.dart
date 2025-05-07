import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'error_response.freezed.dart';

@freezed
class ErrorResponse with _$ErrorResponse {
  const factory ErrorResponse({
    String? code,
    String? message,
  }) = _ErrorResponse;

  static ErrorResponse from(dynamic error) {
    if (error is AuthException) {
      return ErrorResponse(code: 'auth-exception', message: error.message);
    } else if (error is PostgrestException) {
      return ErrorResponse(
          code: 'postgres-exception:${error.code}', message: error.message);
    } else if (error is StorageException) {
      return ErrorResponse(code: 'storage-exception', message: error.message);
    } else {
      return ErrorResponse(message: error.toString());
    }
  }
}
