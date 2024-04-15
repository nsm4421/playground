import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/error/custom_exception.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/chat/message/chat_message.data_source.dart';
import 'package:hot_place/data/entity/chat/message/chat_message.entity.dart';
import 'package:hot_place/domain/model/chat/message/chat_message.model.dart';
import 'package:hot_place/domain/repository/chat/chat_message.repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ChatMessageRepository)
class ChatMessageRepositoryImpl extends ChatMessageRepository {
  final RemoteChatMessageDataSource _chatMessageDataSource;

  ChatMessageRepositoryImpl(this._chatMessageDataSource);

  @override
  Stream<List<ChatMessageEntity>> getChatMessageStream(String chatId) {
    return _chatMessageDataSource.getChatMessageStream(chatId).asyncMap(
        (data) async => data.map(ChatMessageEntity.fromModel).toList());
  }

  @override
  Future<Either<Failure, String>> createChatMessage(
      ChatMessageEntity chat) async {
    try {
      return await _chatMessageDataSource
          .createChatMessage(ChatMessageModel.fromEntity(chat))
          .then((messageId) => right(messageId));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteChatMessageById(
      String messageId) async {
    try {
      return await _chatMessageDataSource
          .deleteChatMessageById(messageId)
          .then((messageId) => right(messageId));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }
}
