import 'package:fpdart/fpdart.dart';
import 'package:hot_place/data/entity/chat/private_chat/room/private_chat.entity.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/repository/chat/room/chat.repository.dart';

import '../../../../core/error/failure.constant.dart';

abstract interface class PrivateChatRepository
    implements ChatRepository<PrivateChatEntity> {
  Future<Either<Failure, PrivateChatEntity>> getChatByUsers(
      {required UserEntity currentUser, required UserEntity opponentUser});
}
