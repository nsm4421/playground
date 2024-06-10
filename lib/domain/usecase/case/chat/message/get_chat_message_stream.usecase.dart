part of '../../../module/chat/chat_message.usecase.dart';

class GetChatMessageStreamUseCase {
  final ChatMessageRepository _repository;

  GetChatMessageStreamUseCase(this._repository);

  Stream<List<ChatMessageEntity>> call(String chatId) =>
      _repository.getMessageStream(chatId);
}
