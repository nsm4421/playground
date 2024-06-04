import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/exception/failure.dart';
import 'package:my_app/data/entity/chat/chat.entity.dart';
import 'package:my_app/data/entity/chat/chat_message.entity.dart';
import 'package:my_app/domain/model/chat/chat.model.dart';
import 'package:my_app/domain/model/chat/chat_message.model.dart';
import '../../../core/exception/custom_exception.dart';
import '../../datasource/chat/chat.datasource_impl.dart';

part 'package:my_app/domain/repository/chat/chat.repository.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final RemoteChatDataSource _remoteDataSource;

  ChatRepositoryImpl({required RemoteChatDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Stream<List<ChatEntity>> getChatStream() => _remoteDataSource
      .getChatStream()
      .asyncMap((event) => event.map(ChatEntity.fromModel).toList());

  @override
  Stream<List<ChatMessageEntity>> getMessageStream(String chatId) =>
      _remoteDataSource
          .getMessageStream(chatId)
          .asyncMap((event) => event.map(ChatMessageEntity.fromModel).toList());

  @override
  Future<Either<Failure, void>> sendChatMessage(
      ChatMessageEntity entity) async {
    try {
      final model = ChatMessageModel.fromEntity(entity);
      await _remoteDataSource.saveChatMessage(model);
      await _remoteDataSource.updateLastMessage(model);
      return right(null);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteChat(ChatEntity entity) async {
    try {
      final model = ChatModel.fromEntity(entity);
      await _remoteDataSource.deleteChat(model);
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
