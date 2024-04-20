import 'package:fpdart/src/either.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/chat/private_chat/message/local_data_source.dart';
import 'package:hot_place/data/data_source/chat/private_chat/message/remote_data_source.dart';
import 'package:hot_place/data/entity/chat/private_chat/message/private_chat_message.entity.dart';
import 'package:injectable/injectable.dart';

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
  Future<Either<Failure, String>> createChatMessage(
      PrivateChatMessageEntity chat) {
    // TODO: implement createChatMessage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> deleteChatMessageById(String messageId) {
    // TODO: implement deleteChatMessageById
    throw UnimplementedError();
  }

  @override
  Stream<List<PrivateChatMessageEntity>> getChatMessageStream(String chatId) {
    // TODO: implement getChatMessageStream
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PrivateChatMessageEntity>>>
      getChatMessagesFromLocalDB(String chatId) {
    // TODO: implement getChatMessagesFromLocalDB
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> saveChatMessageInLocalDB(
      Iterable<PrivateChatMessageEntity> messages) {
    // TODO: implement saveChatMessageInLocalDB
    throw UnimplementedError();
  }
}
