import 'package:hot_place/domain/entity/chat/chat.entity.dart';
import 'package:hot_place/domain/repository/chat/chat.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class CreateChatUseCase {
  final ChatRepository _repository;

  CreateChatUseCase(this._repository);

  Future<void> call(ChatEntity chat) => _repository.createChat(chat);
}
