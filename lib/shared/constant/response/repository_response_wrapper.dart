import '../enums/error_code.enum.dart';
import 'custom_exception.dart';

abstract class RepositoryResponseWrapper<T> {
  const RepositoryResponseWrapper({this.message});

  final String? message;

  bool get ok;
}

class RepositorySuccess<T> extends RepositoryResponseWrapper<T> {
  final T data;

  @override
  bool get ok => true;

  const RepositorySuccess(this.data, {super.message});

  factory RepositorySuccess.from(data, {String? message}) =>
      RepositorySuccess(data, message: message);
}

class RepositoryError<T> extends RepositoryResponseWrapper<T> {
  final ErrorCode code;
  final Exception? exception;

  @override
  bool get ok => false;

  const RepositoryError(
      {required this.code, required super.message, this.exception});

  factory RepositoryError.from(Exception exception, {String? message}) {
    return RepositoryError(
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
