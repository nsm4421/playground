import 'package:hot_place/domain/entity/chat/chat.entity.dart';
import 'package:hot_place/domain/entity/result/result.entity.dart';
import 'package:hot_place/domain/repository/chat/chat.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetChatStreamUseCase {
  final ChatRepository _repository;

  GetChatStreamUseCase(this._repository);

  Future<ResultEntity<Stream<List<ChatEntity>>>> call() async =>
      await _repository.getChatStream().then(ResultEntity.fromResponse);
}
