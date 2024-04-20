import 'package:fpdart/fpdart.dart';
import 'package:hot_place/data/entity/chat/open_chat/room/open_chat.entity.dart';
import 'package:hot_place/domain/repository/chat/room/open_chat.repository.dart';

import '../../../../../core/error/failure.constant.dart';

class ModifyOpenChatUseCase {
  final OpenChatRepository _repository;

  ModifyOpenChatUseCase(this._repository);

  Future<Either<Failure, String>> call(OpenChatEntity chat) async {
    return await _repository.modifyChat(chat);
  }
}
