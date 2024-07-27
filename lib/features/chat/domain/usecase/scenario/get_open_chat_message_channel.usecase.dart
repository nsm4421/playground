part of "../chat.usecase_module.dart";

class GetOpenChatMessageChannelUseCase {
  final OpenChatMessageRepository _repository;

  GetOpenChatMessageChannelUseCase(this._repository);

  RealtimeChannel call(
      {required String chatId,
      required void Function(ChatMessageEntity entity) onInsert}) {
    return _repository.getMessageChannel(chatId: chatId, onInsert: onInsert);
  }
}
