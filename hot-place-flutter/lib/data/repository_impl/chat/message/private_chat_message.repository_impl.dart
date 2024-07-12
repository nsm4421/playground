import 'package:fpdart/src/either.dart';
import 'package:hot_place/core/error/custom_exception.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/chat/private_chat/message/local_data_source.dart';
import 'package:hot_place/data/data_source/chat/private_chat/message/remote_data_source.dart';
import 'package:hot_place/data/entity/chat/private_chat/message/private_chat_message.entity.dart';
import 'package:hot_place/domain/model/chat/private_chat/message/private_chat_message.model.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/model/chat/private_chat/message/private_chat_message.local_model.dart';
import '../../../../domain/repository/chat/message/private_chat_message.repository.dart';

@LazySingleton(as: PrivateChatMessageRepository)
class PrivateChatMessageRepositoryImpl implements PrivateChatMessageRepository {
  final RemotePrivateChatMessageDataSource _remoteDataSource;
  final LocalPrivateChatMessageDataSource _localDataSource;

  PrivateChatMessageRepositoryImpl(
      {required RemotePrivateChatMessageDataSource remoteDataSource,
      required LocalPrivateChatMessageDataSource localDataSource})
      : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Stream<List<PrivateChatMessageEntity>> getChatMessageStream(String chatId) {
    return _remoteDataSource.getChatMessageStream(chatId).asyncMap(
        (data) => data.map(PrivateChatMessageEntity.fromModel).toList());
  }

  @override
  Future<Either<Failure, void>> createChatMessage(
      PrivateChatMessageEntity chat) async {
    try {
      await _localDataSource
          .saveChatMessages([LocalPrivateChatMessageModel.fromEntity(chat)]);
      await _remoteDataSource
          .createChatMessage(PrivateChatMessageModel.fromEntity(chat));
      return right(null);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteChatMessageById(String messageId) async {
    try {
      await _localDataSource.deleteChatMessageById(messageId);
      await _remoteDataSource.deleteChatMessageById(messageId);
      return right(null);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, List<PrivateChatMessageEntity>>>
      getChatMessagesFromLocalDB(String chatId) async {
    try {
      final messages = await _localDataSource
          .getChatMessages(chatId)
          .then((res) => res.map(PrivateChatMessageEntity.fromLocalModel));
      return right(messages.toList());
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveChatMessageInLocalDB(
      Iterable<PrivateChatMessageEntity> messages) async {
    try {
      await _localDataSource.saveChatMessages(
          messages.map(LocalPrivateChatMessageModel.fromEntity));
      return right(null);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }
}
