part of 'package:my_app/domain/usecase/module/chat/open_chat_message.usecase.dart';

class GetOpenChatMessageChannelUseCase {
  final OpenChatMessageRepository _repository;

  GetOpenChatMessageChannelUseCase(this._repository);

  RealtimeChannel call({
    required String chatId,
    required PostgresChangeEvent changeEvent,
    required void Function(
            OpenChatMessageEntity? oldRecored, OpenChatMessageEntity? newRecord)
        callback,
  }) {
    return _repository.getMessageChannel(
        chatId: chatId, changeEvent: changeEvent, callback: callback);
  }
}
