import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.constant.dart';

abstract interface class ChatMessageRepository<T> {
  Stream<List<T>> getChatMessageStream(String chatId);

  Future<Either<Failure, void>> createChatMessage(T message);

  Future<Either<Failure, void>> deleteChatMessageById(String messageId);

  Future<Either<Failure, List<T>>> getChatMessagesFromLocalDB(String chatId);

  Future<Either<Failure, void>> saveChatMessageInLocalDB(Iterable<T> messages);
}
