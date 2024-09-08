import 'package:flutter_app/shared/constant/constant.export.dart';

abstract class UseCaseResponseWrapper<T> {
  const UseCaseResponseWrapper({this.message});

  bool get ok;

  T? get data;

  fold(
      {void Function(T data)? onSuccess,
      void Function(String message)? onError});

  final String? message;

  factory UseCaseResponseWrapper.from(RepositoryResponseWrapper res,
      {String? successMessage, String? errorMessage}) {
    if (res is RepositorySuccess) {
      return UseCaseSuccess<T>(res.data,
          message: successMessage ?? res.message);
    } else if (res is RepositoryError) {
      return UseCaseError(message: errorMessage ?? res.message);
    } else {
      return const UseCaseError(message: 'repository returns weired response');
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

  factory UseCaseSuccess.from(data, {String? message}) =>
      UseCaseSuccess(data, message: message);
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

  factory UseCaseError.from(data, {String? message}) =>
      UseCaseError(message: message);
}
