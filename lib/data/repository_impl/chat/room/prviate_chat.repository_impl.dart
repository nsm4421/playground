import 'package:fpdart/src/either.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/entity/chat/private_chat/room/private_chat.entity.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/model/chat/private_chat/room/private_chat.model.dart';
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
  Future<Either<Failure, void>> createChat(PrivateChatEntity chat) async {
    throw UnimplementedError(
        '채팅방 만들기 기능은 자칫 채팅방을 여러개 생성하게 될 수 있음.오픈채팅은 문제가 안되지만, DM기능 구현시에는 문제가 될 수 있음');
  }

  @override
  Future<Either<Failure, void>> deleteChatById(String chatId) async {
    try {
      return await _dataSource.deleteChatById(chatId).then((_) => right(null));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }
}
