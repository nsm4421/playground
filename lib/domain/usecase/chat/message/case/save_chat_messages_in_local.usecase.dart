import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/failure.constant.dart';
import '../../../../../data/entity/chat/message/chat_message.entity.dart';
import '../../../../repository/chat/chat_message.repository.dart';

class SaveChatMessagesInLocal {
  final ChatMessageRepository _repository;

  SaveChatMessagesInLocal(this._repository);

  Future<Either<Failure, void>> call(Iterable<ChatMessageEntity> messages) {
    return _repository.saveChatMessageInLocalDB(messages);
  }
}
