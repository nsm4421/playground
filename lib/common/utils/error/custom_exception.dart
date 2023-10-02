import 'package:dio/dio.dart';

import 'error_response.dart';

class CustomException {
  const CustomException();

  static ErrorResponse? setError(error) {
    if (error is Exception) {
      if (error.runtimeType == DioException) {
        final dioError = error as DioException;
        final code = dioError.response?.statusCode.toString() ?? '9999';
        final message = dioError.response?.statusMessage ?? '';

        return ErrorResponse(
          status: 'network error',
          code: code,
          message: message,
        );
      } else {
        final code = '7777';
        final message = 'service is unavailable now';

        return ErrorResponse(
          status: 'unKnown error',
          code: code,
          message: message,
        );
      }
    }
  }
}
