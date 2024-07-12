import 'package:fpdart/fpdart.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

import '../../../../../core/error/failure.constant.dart';
import '../../../../repository/chat/room/private_chat.repository.dart';

class CreatePrivateChat {
  final PrivateChatRepository _repository;

  CreatePrivateChat(this._repository);

  Future<Either<Failure, void>> call({
    required UserEntity currentUser,
    required UserEntity opponentUser,
  }) async {
    return await _repository.getChatByUsers(
        currentUser: currentUser, opponentUser: opponentUser);
  }
}
