import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/entity/chat/message/chat_message.entity.dart';

abstract class ChatMessageRepository {
  Stream<List<ChatMessageEntity>> getChatMessageStream(String chatId);

  Future<Either<Failure, String>> createChatMessage(ChatMessageEntity chat);

  Future<Either<Failure, String>> deleteChatMessageById(String messageId);
}
