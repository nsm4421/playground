import '../enums/error_code.enum.dart';
import 'custom_exception.dart';

abstract class ResponseWrapper<T> {
  const ResponseWrapper(
      {String? message, T? data, ErrorCode? code, Exception? exception})
      : _message = message,
        _data = data,
        _code = code,
        _exception = exception;

  final String? _message;
  final T? _data;
  final ErrorCode? _code;
  final Exception? _exception;

  String? get message => _message;

  T? get data => _data;

  ErrorCode? get code => _code;

  bool get ok;

  ResponseWrapper<T> copyWith({
    T? data,
    String? message,
  });
}

class SuccessResponse<T> extends ResponseWrapper<T> {
  @override
  T? get data => _data;

  @override
  bool get ok => true;

  const SuccessResponse({super.message, super.data});

  factory SuccessResponse.from(T? data, {String? message}) =>
      SuccessResponse<T>(data: data, message: message);

  @override
  SuccessResponse<T> copyWith({T? data, String? message}) {
    return SuccessResponse<T>(
        data: data ?? this.data, message: message ?? this.message);
  }
}

class ErrorResponse<T> extends ResponseWrapper<T> {
  @override
  T? get data => null;

  @override
  bool get ok => false;

  @override
  ErrorCode get code => _code!;

  const ErrorResponse({super.data, super.code, super.message, super.exception});

  factory ErrorResponse.from(Exception exception, {String? message}) {
    return ErrorResponse<T>(
        data: null,
        code: exception is CustomException
            ? exception.code
            : ErrorCode.unknownError,
        message: message ??
            (exception is CustomException
                    ? exception.code
                    : ErrorCode.unknownError)
                .description,
        exception: exception);
  }

  @override
  ErrorResponse<T> copyWith(
      {T? data, String? message, ErrorCode? code, Exception? exception}) {
    return ErrorResponse<T>(
        data: data ?? this.data,
        code: code ?? this.code,
        exception: exception ?? _exception,
        message: message ?? this.message);
  }
}
