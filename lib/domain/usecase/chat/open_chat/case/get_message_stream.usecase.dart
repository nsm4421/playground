import 'package:hot_place/data/entity/chat/open_chat/message/open_chat_message.entity.dart';
import 'package:hot_place/domain/repository/chat/message/open_chat_message.repository.dart';

class GetMessageStreamUseCase {
  final OpenChatMessageRepository _repository;

  GetMessageStreamUseCase(this._repository);

  Stream<List<OpenChatMessageEntity>> call(String chatId) {
    return _repository.getChatMessageStream(chatId);
  }
}
