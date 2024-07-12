import 'package:hot_place/domain/repository/chat/message/chat_message.repository.dart';

class GetMessageStreamUseCase<T extends ChatMessageRepository<S>, S> {
  final T _repository;

  GetMessageStreamUseCase(this._repository);

  Stream<List<S>> call(String chatId) =>
      _repository.getChatMessageStream(chatId);
}
