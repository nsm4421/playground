part of 'package:my_app/domain/usecase/module/chat/private_chat_message.usecase.dart';

class FetchLatestMessagesUseCase {
  final PrivateChatMessageRepository _repository;

  FetchLatestMessagesUseCase(this._repository);

  Future<Either<Failure, List<PrivateChatMessageEntity>>> call() async {
    return await _repository.fetchLatestMessages();
  }
}
