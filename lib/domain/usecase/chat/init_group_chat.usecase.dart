part of '../export.usecase.dart';

class InitGroupChatUseCase {
  final GroupChatRepository _repository;

  InitGroupChatUseCase(this._repository);

  void call() => _repository.init();
}
