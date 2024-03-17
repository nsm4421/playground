import 'package:hot_place/data/model/response/response.model.dart';

import '../../entity/chat/chat.entity.dart';
import '../../entity/chat/message.entity.dart';

abstract class ChatRepository {
  Future<ResponseModel<Stream<List<ChatEntity>>>> getChatStream();

  Future<ResponseModel<ChatEntity>> findChatById(String chatId);

  Future<ResponseModel<Stream<List<MessageEntity>>>> getMessageStream(
      MessageEntity message);

  Future<ResponseModel<void>> sendMessage(MessageEntity message);

  Future<ResponseModel<void>> seenMessageUpdate(MessageEntity message);

  Future<ResponseModel<void>> deleteMessage(MessageEntity message);

  Future<ResponseModel<void>> deleteChat(ChatEntity chat);
}
