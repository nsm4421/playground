import 'package:my_app/domain/model/chat/chat.model.dart';

import '../../core/constant/chat.enum.dart';
import '../../core/response/response.dart';
import '../../domain/model/chat/message.model.dart';
import '../base/repository.dart';

abstract class ChatRepository extends Repository {
  /// find chat id which is direct message by opponent uid
  /// or else create chat and return its id
  Future<Response<String>> getDirectMessageChatId(String opponentUid);

  /// get message stream by chat id
  Future<Stream<List<MessageModel>>> getMessageStreamByChatId(String chatId);

  /// send message
  Future<Response<void>> sendMessage({
    required String chatId,
    required MessageType type,
    required String content,
  });
}
