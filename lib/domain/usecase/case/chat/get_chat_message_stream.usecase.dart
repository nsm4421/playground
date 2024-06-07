part of '../../module/chat/chat.usecase.dart';

class GetChatMessageStreamUseCase {
  final ChatRepository _repository;

  GetChatMessageStreamUseCase(this._repository);

  Stream<List<ChatMessageEntity>> call(String chatId) =>
      _repository.getMessageStream(chatId);
}
