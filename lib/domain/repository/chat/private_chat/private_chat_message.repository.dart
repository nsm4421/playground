part of 'package:my_app/data/repository_impl/chat/private_chat/private_chat_message_repository_impl.dart';

abstract interface class PrivateChatMessageRepository {
  Future<Either<Failure, List<PrivateChatMessageEntity>>> fetchLatestMessages();

  Future<Either<Failure, List<PrivateChatMessageEntity>>> fetchMessagesByUser(
      String opponentUid);

  Future<Either<Failure, void>> saveChatMessage(
      PrivateChatMessageEntity entity);

  Future<Either<Failure, void>> deleteChatMessage(String messageId);
}
