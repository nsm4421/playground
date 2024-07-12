import 'package:hot_place/domain/repository/chat/message/chat_message.repository.dart';

class GetMessagesFromLocal<T extends ChatMessageRepository<S>, S> {
  final T _repository;

  GetMessagesFromLocal(this._repository);

  Future<List<S>> call(String chatId) async {
    final res = await _repository.getChatMessagesFromLocalDB(chatId);
    return res.fold((l) => <S>[], (r) => r);
  }
}
