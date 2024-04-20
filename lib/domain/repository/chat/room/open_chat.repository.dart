import 'package:fpdart/fpdart.dart';
import 'package:hot_place/data/entity/chat/open_chat/room/open_chat.entity.dart';
import 'package:hot_place/domain/repository/chat/room/chat.repository.dart';

import '../../../../core/error/failure.constant.dart';

abstract interface class OpenChatRepository
    implements ChatRepository<OpenChatEntity> {
  // 채팅 수정기능은 오픈채팅에서만 구현
  Future<Either<Failure, String>> modifyChat(OpenChatEntity chat);
}
