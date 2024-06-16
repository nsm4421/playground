part of 'package:my_app/data/repository_impl/chat/open_chat/open_chat.reopsitory_impl.dart';

abstract interface class OpenChatRepository {
  Stream<List<OpenChatEntity>> get chatStream;

  Future<Either<Failure, void>> saveChat(OpenChatEntity entity);

  Future<Either<Failure, void>> modifyChat(String chatId,
      {String? title, DateTime? lastTalkAt, String? lastMessage});

  Future<Either<Failure, void>> deleteChatById(String chatId);
}
