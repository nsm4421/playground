import 'package:hot_place/domain/entity/chat/message.entity.dart';
import 'package:hot_place/domain/entity/result/result.entity.dart';
import 'package:hot_place/domain/repository/chat/chat.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class DeleteMessageUseCase {
  final ChatRepository _repository;

  DeleteMessageUseCase(this._repository);

  Future<ResultEntity<void>> call(MessageEntity message) =>
      _repository.deleteMessage(message).then(ResultEntity.fromResponse);
}
