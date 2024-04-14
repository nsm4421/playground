import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/error/custom_exception.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/chat/open_chat/open_chat.data_source.dart';
import 'package:hot_place/data/entity/chat/open_chat/open_chat.entity.dart';
import 'package:hot_place/domain/model/chat/open_chat/open_chat.model.dart';
import 'package:hot_place/domain/repository/chat/open_chat.repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: OpenChatRepository)
class OpenChatRepositoryImpl extends OpenChatRepository {
  final OpenChatDataSource _openChatDataSource;

  OpenChatRepositoryImpl(this._openChatDataSource);

  @override
  Stream<List<OpenChatEntity>> get openChatStream =>
      _openChatDataSource.openChatStream.map((data) =>
          data.map((model) => OpenChatEntity.fromModel(model)).toList());

  @override
  Future<Either<Failure, OpenChatEntity>> createOpenChat(
      OpenChatEntity openChat) async {
    try {
      return await _openChatDataSource
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
      return await _openChatDataSource
          .modifyOpenChat(OpenChatModel.fromEntity(openChat))
          .then((chatId) => right(chatId));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteOpenChatById(String openChatId) async {
    try {
      return await _openChatDataSource
          .deleteOpenChatById(openChatId)
          .then((_) => right(null));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }
}
