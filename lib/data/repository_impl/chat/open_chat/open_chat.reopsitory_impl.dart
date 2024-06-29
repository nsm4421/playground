import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/exception/failure.dart';
import 'package:my_app/domain/model/chat/base/open_chat.model.dart';
import '../../../../core/exception/custom_exception.dart';
import '../../../datasource/chat/impl/open_chat.remote_datasource_impl.dart';
import '../../../entity/chat/open_chat/open_chat.entity.dart';

part '../../../../domain/repository/chat/open_chat/open_chat.repository.dart';

@LazySingleton(as: OpenChatRepository)
class OpenChatRepositoryImpl implements OpenChatRepository {
  final RemoteOpenChatDataSource _remoteDataSource;

  OpenChatRepositoryImpl(this._remoteDataSource);

  @override
  Stream<List<OpenChatEntity>> get chatStream => _remoteDataSource.chatStream
      .asyncMap((event) => event.map(OpenChatEntity.fromModel).toList());

  @override
  Future<Either<Failure, void>> saveChat(OpenChatEntity entity) async {
    try {
      return await _remoteDataSource
          .saveChat(OpenChatModel.fromEntity(entity))
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> modifyChat(String chatId,
      {String? title, DateTime? lastTalkAt, String? lastMessage}) async {
    try {
      return await _remoteDataSource
          .modifyChat(chatId,
              title: title, lastMessage: lastMessage, lastTalkAt: lastTalkAt)
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteChatById(String chatId) async {
    try {
      return await _remoteDataSource.deleteChatById(chatId).then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }
}
