import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/failure.constant.dart';
import '../../../../repository/chat/message/chat_message.repository.dart';

class DeleteChatMessageUseCase<T extends ChatMessageRepository<S>, S> {
  final T _repository;

  DeleteChatMessageUseCase(this._repository);

  Future<Either<Failure, String>> call(String messageId) =>
      _repository.deleteChatMessageById(messageId);
}
