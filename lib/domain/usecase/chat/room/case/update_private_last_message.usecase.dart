import 'package:fpdart/fpdart.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

import '../../../../../core/error/failure.constant.dart';
import '../../../../repository/chat/room/private_chat.repository.dart';

class UpdatePrivateLastMessageUseCase {
  final PrivateChatRepository _repository;

  UpdatePrivateLastMessageUseCase(this._repository);

  Future<Either<Failure, void>> call({
    required UserEntity currentUser,
    required UserEntity receiver,
    required String lastMessage,
    DateTime? lastTalkAt,
  }) async {
    return await _repository.updateLastMessage(
        currentUid: currentUser.id!,
        opponentUid: receiver.id!,
        lastMessage: lastMessage,
        lastTalkAt: lastTalkAt);
  }
}
