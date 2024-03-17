import 'package:hot_place/domain/entity/chat/chat.entity.dart';
import 'package:hot_place/domain/entity/result/result.entity.dart';
import 'package:hot_place/domain/repository/chat/chat.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetChatByIdUseCase {
  final ChatRepository _repository;

  GetChatByIdUseCase(this._repository);

  Future<ResultEntity<ChatEntity>> call(String chatId) =>
      _repository.findChatById(chatId).then(ResultEntity.fromResponse);
}
