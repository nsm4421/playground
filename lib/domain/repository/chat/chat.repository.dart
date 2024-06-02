import 'package:fpdart/fpdart.dart';
import 'package:my_app/core/exception/failure.dart';
import 'package:my_app/data/entity/chat/chat.entity.dart';
import 'package:my_app/data/entity/chat/chat_message.entity.dart';

abstract interface class ChatRepository {
  Stream<List<ChatEntity>> getChatStream();

  Stream<List<ChatMessageEntity>> getMessageStream(String chatId);

  Future<Either<Failure, void>> sendChatMessage(ChatMessageEntity entity);

  Future<Either<Failure, void>> deleteChat(ChatEntity entity);

  Future<Either<Failure, void>> deleteChatMessage(ChatMessageEntity entity);
}
