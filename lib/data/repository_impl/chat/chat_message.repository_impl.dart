import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/exception/failure.dart';
import 'package:my_app/data/entity/chat/message/chat_message.entity.dart';
import 'package:my_app/domain/model/chat/message/chat_message.model.dart';
import '../../../core/exception/custom_exception.dart';
import '../../datasource/chat/message/chat_message.datasource_impl.dart';

part 'package:my_app/domain/repository/chat/chat_message.repository.dart';

@LazySingleton(as: ChatMessageRepository)
class ChatMessageRepositoryImpl implements ChatMessageRepository {
  final RemoteChatMessageDataSource _remoteDataSource;

  ChatMessageRepositoryImpl({required RemoteChatMessageDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Stream<List<ChatMessageEntity>> getMessageStream(String chatId) =>
      _remoteDataSource
          .getChatMessageStream(chatId)
          .asyncMap((event) => event.map(ChatMessageEntity.fromModel).toList());

  @override
  Future<Either<Failure, void>> sendChatMessage(
      ChatMessageEntity entity) async {
    try {
      final model = ChatMessageModel.fromEntity(entity);
      await _remoteDataSource.saveChatMessage(model);
      // TODO : 가장 마자막 메세지 업데이트
      return right(null);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteChatMessage(
      ChatMessageEntity entity) async {
    try {
      final model = ChatMessageModel.fromEntity(entity);
      await _remoteDataSource.deleteChatMessage(model);
      return right(null);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }
}
