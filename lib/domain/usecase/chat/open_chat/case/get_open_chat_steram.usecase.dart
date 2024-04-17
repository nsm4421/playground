import 'package:hot_place/data/entity/chat/open_chat/room/open_chat.entity.dart';

import 'package:hot_place/domain/repository/chat/open_chat.repository.dart';

class GetOpenChatStreamUseCase {
  final OpenChatRepository _repository;

  GetOpenChatStreamUseCase(this._repository);

  Stream<List<OpenChatEntity>> call() => _repository.openChatStream;
}
