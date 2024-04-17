import 'package:hot_place/data/entity/chat/message/chat_message.entity.dart';

import '../../../../repository/chat/chat_message.repository.dart';

class GetLocalChatMessagesUseCase {
  final ChatMessageRepository _repository;

  GetLocalChatMessagesUseCase(this._repository);

  Future<List<ChatMessageEntity>> call(String chatId) async {
    final res = await _repository.getChatMessagesFromLocalDB(chatId);
    return res.fold((l) => <ChatMessageEntity>[], (r) => r);
  }
}
