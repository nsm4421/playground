import 'package:hot_place/data/entity/chat/message/chat_message.entity.dart';
import 'package:hot_place/domain/repository/chat/chat_message.repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetMessageStreamUseCase {
  final ChatMessageRepository _repository;

  GetMessageStreamUseCase(this._repository);

  Stream<List<ChatMessageEntity>> call(String chatId) {
    return _repository.getChatMessageStream(chatId);
  }
}
