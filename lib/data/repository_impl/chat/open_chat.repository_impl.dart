import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/error/custom_exception.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/entity/chat/open_chat/room/open_chat.entity.dart';
import 'package:hot_place/domain/model/chat/open_chat/room/open_chat.model.dart';
import 'package:hot_place/domain/repository/chat/open_chat.repository.dart';
import 'package:injectable/injectable.dart';

import '../../data_source/chat/open_chat/room/remote_data_source.dart';

@Singleton(as: OpenChatRepository)
class OpenChatRepositoryImpl extends OpenChatRepository {
  final RemoteOpenChatDataSource _remoteDataSource;

  OpenChatRepositoryImpl(this._remoteDataSource);

  @override
  Stream<List<OpenChatEntity>> get openChatStream =>
      _remoteDataSource.openChatStream.asyncMap((data) async =>
          data.map((model) => OpenChatEntity.fromModel(model)).toList());

  @override
  Future<Either<Failure, OpenChatEntity>> createOpenChat(
      OpenChatEntity openChat) async {
    try {
      return await _remoteDataSource
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
      return await _remoteDataSource
          .modifyOpenChat(OpenChatModel.fromEntity(openChat))
          .then((chatId) => right(chatId));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteOpenChatById(String openChatId) async {
    try {
      return await _remoteDataSource
          .deleteOpenChatById(openChatId)
          .then((_) => right(null));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }
}
