import 'package:hot_place/domain/entity/chat/message.entity.dart';
import 'package:hot_place/domain/entity/result/result.entity.dart';
import 'package:hot_place/domain/repository/chat/chat.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetMessageStreamUseCase {
  final ChatRepository _repository;

  GetMessageStreamUseCase(this._repository);

  Future<ResultEntity<Stream<List<MessageEntity>>>> call(
          String chatRoomId) async =>
      await _repository
          .getMessageStream(chatRoomId)
          .then(ResultEntity.fromResponse);
}
