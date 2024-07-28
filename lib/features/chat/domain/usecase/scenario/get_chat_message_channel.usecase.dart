part of "../chat.usecase_module.dart";

class GetPrivateChatMessageChannelUseCase {
  final PrivateChatMessageRepository _repository;

  GetPrivateChatMessageChannelUseCase(this._repository);

  RealtimeChannel call({
    required String currentUid,
    required void Function(PrivateChatMessageEntity entity) onInsert,
    required void Function(PrivateChatMessageEntity entity) onDelete,
  }) {
    return _repository.getMessageChannel(
        currentUid: currentUid, onInsert: onInsert, onDelete: onDelete);
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
