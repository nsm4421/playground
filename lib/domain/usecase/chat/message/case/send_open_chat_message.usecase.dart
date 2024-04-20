import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

import '../../../../../core/error/failure.constant.dart';
import '../../../../../data/entity/chat/open_chat/message/open_chat_message.entity.dart';
import '../../../../repository/chat/message/open_chat_message.repository.dart';

class SendOpenChatMessageUseCase {
  final OpenChatMessageRepository _repository;

  SendOpenChatMessageUseCase(this._repository);

  Future<Either<Failure, String>> call(
      {required String chatId,
      required String content,
      required UserEntity currentUser}) async {
    final messageId = UuidUtil.uuid();
    return _repository.createChatMessage(OpenChatMessageEntity(
        chatId: chatId,
        id: messageId,
        content: content,
        sender: currentUser,
        createdAt: DateTime.now()));
  }
}
