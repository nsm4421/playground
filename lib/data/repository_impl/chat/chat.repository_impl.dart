import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/error/custom_exception.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/chat/chat.data_source.dart';
import 'package:hot_place/data/entity/chat/open_chat/open_chat.entity.dart';
import 'package:hot_place/domain/model/chat/open_chat/open_chat.model.dart';
import 'package:hot_place/domain/repository/chat/chat.repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ChatRepository)
class ChatRepositoryImpl extends ChatRepository {
  final ChatDataSource _chatDataSource;

  ChatRepositoryImpl(this._chatDataSource);

  @override
  Stream<List<OpenChatEntity>> get openChatStream =>
      _chatDataSource.openChatStream.map((data) =>
          data.map((model) => OpenChatEntity.fromModel(model)).toList());

  @override
  Future<Either<Failure, OpenChatEntity>> createOpenChat(
      OpenChatEntity openChat) async {
    try {
      return await _chatDataSource
          .createOpenChat(OpenChatModel.fromEntity(openChat))
          .then((model) => OpenChatEntity.fromModel(model))
          .then((entity) => right(entity));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, String>> modifyOpenChat(
      OpenChatEntity openChat) async {
    try {
      return await _chatDataSource
          .modifyOpenChat(OpenChatModel.fromEntity(openChat))
          .then((chatId) => right(chatId));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteOpenChatById(String openChatId) async {
    try {
      return await _chatDataSource
          .deleteOpenChatById(openChatId)
          .then((_) => right(null));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }
}
