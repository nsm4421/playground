part of "../chat.usecase_module.dart";

class GetConversationChannelUseCase {
  final PrivateChatMessageRepository _repository;

  GetConversationChannelUseCase(this._repository);

  RealtimeChannel call({
    required String chatId,
    required void Function(PrivateChatMessageEntity entity) onInsert,
    required void Function(PrivateChatMessageEntity entity) onDelete,
  }) {
    return _repository.getConversationChannel(
        chatId: chatId, onInsert: onInsert, onDelete: onDelete);
  }
}

class GetLastChatChannelUseCase {
  final PrivateChatMessageRepository _repository;

  GetLastChatChannelUseCase(this._repository);

  RealtimeChannel call({
    required void Function(PrivateChatMessageEntity entity) onInsert,
    required void Function(PrivateChatMessageEntity entity) onDelete,
  }) {
    return _repository.getLastChatChannel(
        onInsert: onInsert, onDelete: onDelete);
  }
}

class GetOpenChatMessageChannelUseCase {
  final OpenChatMessageRepository _repository;

  GetOpenChatMessageChannelUseCase(this._repository);

  RealtimeChannel call(
      {required String chatId,
      required void Function(OpenChatMessageEntity entity) onInsert}) {
    return _repository.getMessageChannel(chatId: chatId, onInsert: onInsert);
  }
}
