part of 'package:my_app/data/repository_impl/chat/chat.repository_impl.dart';

abstract interface class ChatRepository {
  Stream<List<ChatEntity>> getChatStream();

  Future<Either<Failure, void>> deleteChat(ChatEntity entity);
}
