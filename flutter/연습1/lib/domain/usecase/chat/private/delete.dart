part of 'usecase.dart';

class DeleteChatUseCase with CustomLogger {
  final PrivateChatRepository _repository;

  DeleteChatUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(String chatId) async {
    return await _repository.delete(chatId);
  }
}

class DeleteMessageUseCase with CustomLogger {
  final PrivateMessageRepository _repository;

  DeleteMessageUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(String messageId) async {
    return await _repository.delete(messageId);
  }
}
