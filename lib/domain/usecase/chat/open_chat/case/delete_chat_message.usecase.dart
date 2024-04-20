import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/failure.constant.dart';
import '../../../../repository/chat/message/open_chat_message.repository.dart';

class DeleteChatMessageUseCase {
  final OpenChatMessageRepository _repository;

  DeleteChatMessageUseCase(this._repository);

  Future<Either<Failure, String>> call(String messageId) async {
    return _repository.deleteChatMessageById(messageId);
  }
}
