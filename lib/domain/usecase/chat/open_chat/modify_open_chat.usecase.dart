import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/entity/chat/open_chat/open_chat.entity.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/repository/chat/chat.repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.constant.dart';

@lazySingleton
class ModifyOpenChatUseCase {
  final ChatRepository _repository;

  ModifyOpenChatUseCase(this._repository);

  Future<Either<Failure, String>> call(OpenChatEntity openChat) async {
    return await _repository.modifyOpenChat(openChat);
  }
}
