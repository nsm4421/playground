import 'package:hot_place/data/entity/chat/open_chat/open_chat.entity.dart';

import 'package:hot_place/domain/repository/chat/open_chat.repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetOpenChatUseCase {
  final OpenChatRepository _repository;

  GetOpenChatUseCase(this._repository);

  Stream<List<OpenChatEntity>> call() => _repository.openChatStream;
}
