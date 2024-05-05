import 'package:fpdart/src/either.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/entity/chat/private_chat/room/private_chat.entity.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/model/user/user.model.dart';
import 'package:hot_place/domain/repository/chat/room/private_chat.repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/custom_exception.dart';
import '../../../data_source/chat/private_chat/room/remote.data_source.dart';

@LazySingleton(as: PrivateChatRepository)
class PrivateChatRepositoryImpl implements PrivateChatRepository {
  final RemotePrivateChatDataSource _dataSource;

  PrivateChatRepositoryImpl(this._dataSource);

  @override
  Stream<List<PrivateChatEntity>> get chatStream => _dataSource
      .getChatStream()
      .asyncMap((event) => event.map(PrivateChatEntity.fromModel).toList());

  @override
  Future<Either<Failure, PrivateChatEntity>> getChatByUsers(
      {required UserEntity currentUser,
      required UserEntity opponentUser}) async {
    try {
      return await _dataSource
          .getChatByUser(
              currentUser: UserModel.fromEntity(currentUser),
              opponentUser: UserModel.fromEntity(opponentUser))
          .then((model) => PrivateChatEntity.fromModel(model))
          .then((entity) => right(entity));
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
      {required String currentUid,
      required String opponentUid,
      required String lastMessage,
      DateTime? lastTalkAt}) async {
    try {
      return await _dataSource
          .updatedLastMessage(
              currentUid: currentUid,
              opponentUid: opponentUid,
              lastTalkAt: lastTalkAt,
              lastMessage: lastMessage)
          .then((_) => right(null));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }
}
