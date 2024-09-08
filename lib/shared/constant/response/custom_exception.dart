import 'package:supabase_flutter/supabase_flutter.dart';

import '../enums/error_code.enum.dart';

class CustomException implements Exception {
  final String message;
  final ErrorCode code;

  CustomException(this.code, {this.message = 'custom exception'});

  @override
  String toString() => 'CustomException: $message';

  factory CustomException.from({Object? error, String? message}) {
    if (error is AuthException) {
      return CustomException(ErrorCode.authError,
          message: message ?? error.message);
    } else if (error is PostgrestException) {
      return CustomException(ErrorCode.authError,
          message: message ?? error.message);
    } else if (error is StorageException) {
      return CustomException(ErrorCode.storageError,
          message: message ?? error.message);
    }
    return CustomException(ErrorCode.unknownError,
        message: message ?? error.toString());
  }
}
