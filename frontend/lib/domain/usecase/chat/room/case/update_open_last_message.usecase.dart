import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/failure.constant.dart';
import '../../../../repository/chat/room/open_chat.repository.dart';

class UpdateOpenLastMessageUseCase {
  final OpenChatRepository _repository;

  UpdateOpenLastMessageUseCase(this._repository);

  Future<Either<Failure, void>> call({
    required String chatId,
    required String lastMessage,
    DateTime? lastTalkAt,
  }) async {
    return await _repository.updateLastMessage(
        chatId: chatId,
        lastMessage: lastMessage,
        lastTalkAt: lastTalkAt);
  }
}
