part of 'package:my_app/domain/usecase/module/chat/private_chat_message.usecase.dart';

class FetchPrivateChatMessagesByUserUseCase {
  final PrivateChatMessageRepository _repository;

  FetchPrivateChatMessagesByUserUseCase(this._repository);

  Future<Either<Failure, List<PrivateChatMessageEntity>>> call(
      String opponentUid) async {
    return await _repository.fetchMessagesByUser(opponentUid);
  }
}
