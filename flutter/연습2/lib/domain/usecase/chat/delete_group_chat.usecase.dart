part of '../export.usecase.dart';

class DeleteGroupChatUseCase {
  final GroupChatRepository _repository;

  DeleteGroupChatUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<void>>> call(
      String chatId) async {
    return await _repository.deleteChat(chatId);
  }
}
