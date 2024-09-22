import '../enums/error_code.enum.dart';
import 'custom_exception.dart';

abstract class RepositoryResponseWrapper<T> {
  const RepositoryResponseWrapper({String? message, T? data})
      : _message = message,
        _data = data;

  final String? _message;
  final T? _data;

  String? get message => _message;

  T? get data => _data;

  bool get ok;
}

class RepositorySuccess<T> extends RepositoryResponseWrapper<T> {
  @override
  T get data => _data!;

  @override
  bool get ok => true;

  const RepositorySuccess({super.message, super.data});

  factory RepositorySuccess.from(T data, {String? message}) =>
      RepositorySuccess(data: data, message: message);
}

class RepositoryError<T> extends RepositoryResponseWrapper<T> {
  final ErrorCode code;
  final Exception? exception;

  @override
  T? get data => null;

  @override
  bool get ok => false;

  const RepositoryError(
      {super.data, required this.code, required super.message, this.exception});

  factory RepositoryError.from(Exception exception, {String? message}) {
    return RepositoryError<T>(
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
}
