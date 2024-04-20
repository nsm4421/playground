import 'package:hot_place/domain/repository/chat/message/chat_message.repository.dart';

class SaveChatMessagesInLocal<T extends ChatMessageRepository, S> {
  final T _repository;

  SaveChatMessagesInLocal(this._repository);

  Future<void> call(Iterable<S> messages) {
    return _repository.saveChatMessageInLocalDB(messages);
  }
}
