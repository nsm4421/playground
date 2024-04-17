import 'package:hot_place/data/entity/chat/open_chat/message/open_chat_message.entity.dart';

import '../../../../repository/chat/open_chat_message.repository.dart';

class GetLocalChatMessagesUseCase {
  final OpenChatMessageRepository _repository;

  GetLocalChatMessagesUseCase(this._repository);

  Future<List<OpenChatMessageEntity>> call(String chatId) async {
    final res = await _repository.getChatMessagesFromLocalDB(chatId);
    return res.fold((l) => <OpenChatMessageEntity>[], (r) => r);
  }
}
