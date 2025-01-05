part of '../export.usecase.dart';

class SendMessageUseCase {
  final ChatRepository _repository;

  SendMessageUseCase(this._repository);

  Either<ErrorResponse, SuccessResponse<void>> call(
      {required String chatId, required String message}) {
    return _repository.sendMessage(chatId: chatId, message: message);
  }
}
