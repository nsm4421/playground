import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/entity/chat/open_chat/room/open_chat.entity.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/repository/chat/room/open_chat.repository.dart';

import '../../../../../core/error/failure.constant.dart';

class CreateOpenChatUseCase {
  final OpenChatRepository _repository;

  CreateOpenChatUseCase(this._repository);

  Future<Either<Failure, OpenChatEntity>> call({
    required String title,
    required List<String> hashtags,
    required UserEntity currentUser,
    required DateTime createdAt,
  }) async {
    final id = UuidUtil.uuid();
    return await _repository.createChat(OpenChatEntity(
        id: id,
        host: currentUser,
        title: title,
        hashtags: hashtags,
        createdAt: createdAt,
        lastMessage: '채팅방이 개설되었습니다',
        lastTalkAt: createdAt));
  }
}
