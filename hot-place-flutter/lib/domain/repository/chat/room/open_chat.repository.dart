import 'package:fpdart/fpdart.dart';
import 'package:hot_place/data/entity/chat/open_chat/room/open_chat.entity.dart';
import 'package:hot_place/domain/repository/chat/room/chat.repository.dart';

import '../../../../core/error/failure.constant.dart';

abstract interface class OpenChatRepository
    implements ChatRepository<OpenChatEntity> {
  Future<Either<Failure, OpenChatEntity>> createChat(OpenChatEntity chat);

  Future<Either<Failure, String>> modifyChat(OpenChatEntity chat);

  Future<Either<Failure, void>> updateLastMessage(
      {required String chatId,
      required String lastMessage,
      DateTime? lastTalkAt});
}
