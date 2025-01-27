part of '../export.usecase.dart';

class DeleteChatUseCase {
  final ChatRepository _repository;

  DeleteChatUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<void>>> call(
      String chatId) async {
    return await _repository.delete(chatId);
  }
}
