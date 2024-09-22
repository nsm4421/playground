import 'package:flutter_app/shared/constant/constant.export.dart';

abstract class UseCaseResponseWrapper<T> {
  const UseCaseResponseWrapper({this.message});

  bool get ok;

  T? get data;

  fold(
      {void Function(T data)? onSuccess,
      void Function(String message)? onError});

  final String? message;

  factory UseCaseResponseWrapper.from(RepositoryResponseWrapper<T> res,
      {String? successMessage, String? errorMessage}) {
    if (res is RepositorySuccess) {
      return UseCaseSuccess<T>(res.data!,
          message: successMessage ?? res.message);
    } else if (res is RepositoryError) {
      return UseCaseError<T>(message: errorMessage ?? res.message);
    } else {
      return UseCaseError<T>(message: 'repository returns weired response');
    }
  }
}

class UseCaseSuccess<T> extends UseCaseResponseWrapper<T> {
  @override
  final T data;

  const UseCaseSuccess(this.data, {super.message});

  @override
  bool get ok => true;

  @override
  fold(
      {void Function(T data)? onSuccess,
      void Function(String errorMessage)? onError}) {
    onSuccess!(data);
  }

  factory UseCaseSuccess.from(T data, {String? message}) =>
      UseCaseSuccess<T>(data, message: message);
}

class UseCaseError<T> extends UseCaseResponseWrapper<T> {
  const UseCaseError({super.message});

  @override
  bool get ok => false;

  @override
  T? get data => null;

  @override
  fold(
      {void Function(T data)? onSuccess,
      void Function(String errorMessage)? onError}) {
    onError!(message ?? '알수없는 오류가 발생했습니다');
  }

  factory UseCaseError.from({RepositoryError<T>? error, String? message}) =>
      UseCaseError<T>(message: message ?? error?.message);
}
