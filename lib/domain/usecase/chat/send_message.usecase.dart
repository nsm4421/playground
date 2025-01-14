part of '../export.usecase.dart';

class SendMessageUseCase {
  final ChatRepository _repository;

  SendMessageUseCase(this._repository);

  Either<ErrorResponse, SuccessResponse<void>> call(
      {required String chatId,
      required String content,
      required String currentUid}) {
    return _repository.sendMessage(
        chatId: chatId, content: content, currentUid: currentUid);
  }
}
