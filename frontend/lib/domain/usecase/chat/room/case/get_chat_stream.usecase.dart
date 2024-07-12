import 'package:hot_place/domain/repository/chat/room/chat.repository.dart';

class GetChatStreamUseCase<T extends ChatRepository<S>, S> {
  final T _repository;

  GetChatStreamUseCase(this._repository);

  Stream<List<S>> call() => _repository.chatStream;
}
