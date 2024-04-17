import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/failure.constant.dart';
import '../../../../../data/entity/chat/open_chat/message/open_chat_message.entity.dart';
import '../../../../repository/chat/open_chat_message.repository.dart';

class SaveChatMessagesInLocal {
  final OpenChatMessageRepository _repository;

  SaveChatMessagesInLocal(this._repository);

  Future<Either<Failure, void>> call(Iterable<OpenChatMessageEntity> messages) {
    return _repository.saveChatMessageInLocalDB(messages);
  }
}
