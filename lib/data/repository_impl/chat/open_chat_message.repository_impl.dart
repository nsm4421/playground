import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/error/custom_exception.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/chat/open_chat/message/remote.data_source.dart';
import 'package:hot_place/data/entity/chat/open_chat/message/open_chat_message.entity.dart';
import 'package:hot_place/domain/repository/chat/open_chat_message.repository.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/model/chat/open_chat/message/open_chat_message.local_model.dart';
import '../../../domain/model/chat/open_chat/message/open_chat_message.model.dart';
import '../../data_source/chat/open_chat/message/local_data_source.dart';

@Singleton(as: OpenChatMessageRepository)
class OpenChatMessageRepositoryImpl extends OpenChatMessageRepository {
  final RemoteOpenChatMessageDataSource _remoteDataSource;
  final LocalOpenChatMessageDataSource _localDataSource;

  OpenChatMessageRepositoryImpl(
      {required RemoteOpenChatMessageDataSource remoteDataSource,
      required LocalOpenChatMessageDataSource localDataSource})
      : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Stream<List<OpenChatMessageEntity>> getChatMessageStream(String chatId) {
    return _remoteDataSource.getChatMessageStream(chatId).asyncMap(
        (data) async => data.map(OpenChatMessageEntity.fromModel).toList());
  }

  @override
  Future<Either<Failure, String>> createChatMessage(
      OpenChatMessageEntity chat) async {
    try {
      return await _remoteDataSource
          .createChatMessage(OpenChatMessageModel.fromEntity(chat))
          .then((messageId) => right(messageId));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteChatMessageById(
      String messageId) async {
    try {
      return await _remoteDataSource
          .deleteChatMessageById(messageId)
          .then((messageId) => right(messageId));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, List<OpenChatMessageEntity>>>
      getChatMessagesFromLocalDB(String chatId) async {
    try {
      final messages = await _localDataSource
          .getChatMessages(chatId)
          .then((res) => res.map(OpenChatMessageEntity.fromLocalModel));
      return right(messages.toList());
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveChatMessageInLocalDB(
      Iterable<OpenChatMessageEntity> messages) async {
    try {
      await _localDataSource.saveChatMessages(
          messages.map((e) => LocalOpenChatMessageModel.fromEntity(e)));
      return right(null);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }
}
