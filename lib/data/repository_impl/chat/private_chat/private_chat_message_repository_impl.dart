import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/exception/failure.dart';
import 'package:my_app/data/datasource/chat/private_chat_message/impl/remote_private_chat_message.datasource_impl.dart';
import 'package:my_app/domain/model/chat/message/local_private_chat_message.model.dart';
import 'package:my_app/domain/model/chat/message/private_chat_message.model.dart';

import '../../../../core/exception/custom_exception.dart';
import '../../../datasource/chat/private_chat_message/impl/local_private_chat_message.datasource_impl.dart';
import '../../../entity/chat/chat_message/private_chat_message.entity.dart';

part 'package:my_app/domain/repository/chat/private_chat/private_chat_message.repository.dart';

@LazySingleton(as: PrivateChatMessageRepository)
class PrivateChatMessageRepositoryImpl implements PrivateChatMessageRepository {
  final LocalPrivateChatMessageDataSource _localDataSource;
  final RemotePrivateChatMessageDataSource _remoteDataSource;

  PrivateChatMessageRepositoryImpl(
      {required LocalPrivateChatMessageDataSource localDataSource,
      required RemotePrivateChatMessageDataSource remoteDataSource})
      : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, void>> deleteChatMessage(String messageId) async {
    try {
      await _remoteDataSource.deleteMessageById(messageId);
      await _localDataSource.deleteMessageById(messageId);
      return right(null);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveChatMessage(
      PrivateChatMessageEntity entity) async {
    try {
      await _remoteDataSource
          .saveChatMessage(PrivateChatMessageModel.fromEntity(entity));
      await _localDataSource
          .saveChatMessage(LocalPrivateChatMessageModel.fromEntity(entity));
      return right(null);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }
}
