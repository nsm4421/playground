import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/entity/chat/message/chat_message.entity.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

import '../../../../../core/error/failure.constant.dart';
import '../../../../repository/chat/chat_message.repository.dart';

class SendChatMessageUseCase {
  final ChatMessageRepository _repository;

  SendChatMessageUseCase(this._repository);

  Future<Either<Failure, String>> call(
      {required String chatId,
      required String content,
      required UserEntity currentUser}) async {
    final messageId = UuidUtil.uuid();
    return _repository.createChatMessage(ChatMessageEntity(
        chatId: chatId,
        id: messageId,
        content: content,
        sender: currentUser,
        createdAt: DateTime.now()));
  }
}
