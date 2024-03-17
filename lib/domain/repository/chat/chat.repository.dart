import 'package:hot_place/data/model/response/response.model.dart';

import '../../entity/chat/chat.entity.dart';
import '../../entity/chat/message.entity.dart';

abstract class ChatRepository {
  /// stream 가져오기
  Future<ResponseModel<Stream<List<ChatEntity>>>> getChatStream();

  Future<ResponseModel<Stream<List<MessageEntity>>>> getMessageStream(
      String chatId);

  /// id로 단건 조회
  Future<ResponseModel<ChatEntity>> findChatById(String chatId);

  Future<ResponseModel<MessageEntity>> findMessageById(
      {required String chatId, required String messageId});

  /// Create
  Future<ResponseModel<void>> sendMessage(MessageEntity message);

  /// Read
  /// Update
  Future<ResponseModel<void>> seenMessageUpdate(MessageEntity message);

  /// Delete
  Future<ResponseModel<void>> deleteChat(ChatEntity chat);

  Future<ResponseModel<void>> deleteMessage(MessageEntity message);
}
