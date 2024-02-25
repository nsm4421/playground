import 'package:hot_place/domain/entity/chat/message.entity.dart';
import 'package:hot_place/domain/repository/chat/chat.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetMessageStreamUseCase {
  final ChatRepository _repository;

  GetMessageStreamUseCase(this._repository);

  Future<Stream<List<MessageEntity>>> call(MessageEntity message) async =>
      await _repository.getMessageStream(message);
}
