import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/error/custom_exception.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/chat/message/chat_message.data_source.dart';
import 'package:hot_place/data/entity/chat/message/chat_message.entity.dart';
import 'package:hot_place/domain/model/chat/message/chat_message.local_model.dart';
import 'package:hot_place/domain/model/chat/message/chat_message.model.dart';
import 'package:hot_place/domain/repository/chat/chat_message.repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ChatMessageRepository)
class ChatMessageRepositoryImpl extends ChatMessageRepository {
  final RemoteChatMessageDataSource _remoteChatMessageDataSource;
  final LocalChatMessageDataSource _localChatMessageDataSource;

  ChatMessageRepositoryImpl(
      {required RemoteChatMessageDataSource remoteChatMessageDataSource,
      required LocalChatMessageDataSource localChatMessageDataSource})
      : _remoteChatMessageDataSource = remoteChatMessageDataSource,
        _localChatMessageDataSource = localChatMessageDataSource;

  @override
  Stream<List<ChatMessageEntity>> getChatMessageStream(String chatId) {
    return _remoteChatMessageDataSource.getChatMessageStream(chatId).asyncMap(
        (data) async => data.map(ChatMessageEntity.fromModel).toList());
  }

  @override
  Future<Either<Failure, String>> createChatMessage(
      ChatMessageEntity chat) async {
    try {
      return await _remoteChatMessageDataSource
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
      return await _remoteChatMessageDataSource
          .deleteChatMessageById(messageId)
          .then((messageId) => right(messageId));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> getChatMessagesFromLocalDB(
      String chatId) async {
    try {
      final messages = await _localChatMessageDataSource
          .getChatMessages(chatId)
          .then((res) => res.map(ChatMessageEntity.fromLocalModel));
      return right(messages.toList());
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveChatMessageInLocalDB(
      Iterable<ChatMessageEntity> messages) async {
    try {
      await _localChatMessageDataSource.saveChatMessages(
          messages.map((e) => LocalChatMessageModel.fromEntity(e)));
      return right(null);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }
}
