import '../../../../../domain/model/chat/open_chat/room/open_chat.model.dart';
import '../../base/room/remote_data_source.dart';

abstract interface class RemoteOpenChatDataSource
    implements RemoteChatDataSource<OpenChatModel> {
  Future<String> modifyChat(OpenChatModel chat);

  Future<void> updatedLastMessage({
    required String chatId,
    required String lastMessage,
    DateTime? lastTalkAt,
  });
}
