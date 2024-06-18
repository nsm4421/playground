part of 'package:my_app/domain/usecase/module/chat/open_chat_message.usecase.dart';

class GetOpenChatMessageChannelUseCase {
  final OpenChatMessageRepository _repository;

  GetOpenChatMessageChannelUseCase(this._repository);

  RealtimeChannel call(
      {required String chatId,
      required void Function(OpenChatMessageEntity entity) onInsert}) {
    return _repository.getMessageChannel(chatId: chatId, onInsert: onInsert);
  }
}
