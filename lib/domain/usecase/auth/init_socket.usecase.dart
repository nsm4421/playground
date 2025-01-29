part of '../export.usecase.dart';

class InitSocketUseCase {
  final AuthRepository _repository;

  InitSocketUseCase(this._repository);

  void call() => _repository.initSocket();
}
