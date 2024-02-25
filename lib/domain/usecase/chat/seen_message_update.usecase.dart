import 'package:hot_place/domain/entity/chat/message.entity.dart';
import 'package:hot_place/domain/repository/chat/chat.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class SeenMessageUpdateUseCase {
  final ChatRepository _repository;

  SeenMessageUpdateUseCase(this._repository);

  Future<void> call(MessageEntity message) =>
      _repository.seenMessageUpdate(message);
}
