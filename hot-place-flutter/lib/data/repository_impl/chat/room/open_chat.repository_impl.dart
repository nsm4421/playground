import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/error/custom_exception.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/entity/chat/open_chat/room/open_chat.entity.dart';
import 'package:hot_place/domain/model/chat/open_chat/room/open_chat.model.dart';
import 'package:hot_place/domain/repository/chat/room/open_chat.repository.dart';
import 'package:injectable/injectable.dart';

import '../../../data_source/chat/open_chat/room/remote_data_source.dart';

@LazySingleton(as: OpenChatRepository)
class OpenChatRepositoryImpl implements OpenChatRepository {
  final RemoteOpenChatDataSource _dataSource;

  OpenChatRepositoryImpl(this._dataSource);

  @override
  Stream<List<OpenChatEntity>> get chatStream =>
      _dataSource.getChatStream().asyncMap((data) async =>
          data.map((model) => OpenChatEntity.fromModel(model)).toList());

  @override
  Future<Either<Failure, OpenChatEntity>> createChat(
      OpenChatEntity chat) async {
    try {
      return await _dataSource
          .createChat(OpenChatModel.fromEntity(chat))
          .then((_) => right(chat));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, String>> modifyChat(OpenChatEntity chat) async {
    try {
      return await _dataSource
          .modifyChat(OpenChatModel.fromEntity(chat))
          .then((chatId) => right(chatId));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteChatById(String chatId) async {
    try {
      return await _dataSource.deleteChatById(chatId).then((_) => right(null));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateLastMessage(
      {required String chatId,
      required String lastMessage,
      DateTime? lastTalkAt}) async {
    try {
      return await _dataSource
          .updatedLastMessage(
              chatId: chatId, lastMessage: lastMessage, lastTalkAt: lastTalkAt)
          .then((_) => right(null));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }
}
