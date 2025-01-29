part of '../export.usecase.dart';

class JoinGroupChatUseCase {
  final GroupChatRepository _repository;

  JoinGroupChatUseCase(this._repository);

  Either<ErrorResponse, SuccessResponse<void>> call(String chatId) {
    return _repository.joinChat(chatId);
  }
}

class LeaveGroupChatUseCase {
  final GroupChatRepository _repository;

  LeaveGroupChatUseCase(this._repository);

  Either<ErrorResponse, SuccessResponse<void>> call(String chatId) {
    return _repository.leaveChat(chatId);
  }
}
