import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/entity/chat/open_chat/message/open_chat_message.entity.dart';

abstract class OpenChatMessageRepository {
  Stream<List<OpenChatMessageEntity>> getChatMessageStream(String chatId);

  Future<Either<Failure, String>> createChatMessage(OpenChatMessageEntity chat);

  Future<Either<Failure, String>> deleteChatMessageById(String messageId);

  Future<Either<Failure, List<OpenChatMessageEntity>>>
      getChatMessagesFromLocalDB(String chatId);

  Future<Either<Failure, void>> saveChatMessageInLocalDB(
      Iterable<OpenChatMessageEntity> messages);
}
