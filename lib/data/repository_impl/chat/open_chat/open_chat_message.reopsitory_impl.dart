import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/datasource/chat/open_chat_message/open_chat_message.datasource_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/exception/custom_exception.dart';
import '../../../../core/exception/failure.dart';
import '../../../../domain/model/chat/message/open_chat_message.model.dart';
import '../../../entity/chat/chat_message/open_chat_message.entity.dart';

part '../../../../domain/repository/chat/open_chat/open_chat_message.repository.dart';

@LazySingleton(as: OpenChatMessageRepository)
class OpenChatRepositoryImpl implements OpenChatMessageRepository {
  final RemoteOpenChatMessageDataSource _remoteDataSource;

  OpenChatRepositoryImpl(this._remoteDataSource);

  @override
  RealtimeChannel getMessageChannel({
    required String chatId,
    required void Function(OpenChatMessageEntity entity) onInsert,
  }) {
    return _remoteDataSource.getMessageChannel(
        chatId: chatId,
        onInsert: (PostgresChangePayload payload) {
          final entity = OpenChatMessageEntity.fromModel(
              OpenChatMessageModel.fromJson(payload.newRecord));
          if (entity.id != null) {
            onInsert(entity);
          }
        });
  }

  @override
  Future<Either<Failure, void>> saveChatMessage(
      OpenChatMessageEntity entity) async {
    try {
      return await _remoteDataSource
          .saveChatMessage(OpenChatMessageModel.fromEntity(entity))
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessageById(String messageId) async {
    try {
      return await _remoteDataSource.deleteMessageById(messageId).then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }
}
