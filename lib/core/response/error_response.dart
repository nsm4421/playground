import 'package:supabase_flutter/supabase_flutter.dart';

import 'error_code.constant.dart';

class ErrorResponse {
  final Exception? exception;
  final ErrorType type;
  final String message;

  ErrorResponse(
      {this.exception,
      this.type = ErrorType.unknownError,
      this.message = 'unknown error'});

  ErrorResponse copyWith(
      {Exception? exception, ErrorType? type, String? message}) {
    return ErrorResponse(
        exception: exception ?? this.exception,
        type: type ?? this.type,
        message: message ?? this.message);
  }

  factory ErrorResponse.from(Exception exception) {
    ErrorType type = ErrorType.unknownError;
    if (exception is AuthException) {
      type = switch (exception.message) {
        'Invalid login credentials' => ErrorType.invalidCredential,
        'User not found' => ErrorType.userNotFound,
        'Email not confirmed' => ErrorType.emailNotConfirmed,
        'Incorrect password' => ErrorType.inCorrectPassword,
        'User already registered' => ErrorType.userAlreadyExist,
        'Invalid email format' => ErrorType.invalidFormat,
        'Password is too weak' => ErrorType.toWeekPassword,
        (_) => ErrorType.auth
      };
    } else if (exception is StorageException) {
      type = ErrorType.storage;
    } else if (exception is PostgrestException) {
      type = ErrorType.db;
    }
    return ErrorResponse(
        exception: exception,
        type: type,
        message: type.description ?? 'error occurs');
  }
}
