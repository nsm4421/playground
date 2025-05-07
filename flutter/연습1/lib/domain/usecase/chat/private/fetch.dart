part of 'usecase.dart';

class FetchChatsUseCase with CustomLogger {
  final PrivateChatRepository _repository;

  FetchChatsUseCase(this._repository);

  Future<Either<ErrorResponse, List<PrivateChatEntity>>> call(
      {required String beforeAt, int take = 20}) async {
    return await _repository.fetch(beforeAt: beforeAt, take: take);
  }
}

class FetchMessagesUseCase with CustomLogger {
  final PrivateMessageRepository _repository;

  FetchMessagesUseCase(this._repository);

  Future<Either<ErrorResponse, List<PrivateMessageEntity>>> call(
      {required String beforeAt, required String chatId, int take = 20}) async {
    return await _repository.fetch(beforeAt: beforeAt, chatId: chatId);
  }
}
