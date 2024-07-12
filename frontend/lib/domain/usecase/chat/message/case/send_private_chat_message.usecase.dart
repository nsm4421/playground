import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/entity/chat/private_chat/message/private_chat_message.entity.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

import '../../../../../core/error/failure.constant.dart';
import '../../../../repository/chat/message/private_chat_message.repository.dart';

class SendPrivateChatMessageUseCase {
  final PrivateChatMessageRepository _repository;

  SendPrivateChatMessageUseCase(this._repository);

  Future<Either<Failure, void>> call({
    required String chatId,
    required String content,
    required UserEntity currentUser,
    required UserEntity receiver,
    required DateTime createdAt,
  }) async {
    final messageId = UuidUtil.uuid();
    return _repository.createChatMessage(PrivateChatMessageEntity(
        id: messageId,
        chatId: chatId,
        sender: currentUser,
        receiver: receiver,
        content: content,
        createdAt: createdAt));
  }
}
