import '../../domain/model/chat/chat_room/chat_room.model.dart';
import '../dto/chat/chat_room/chat_room.dto.dart';

extension ChatRoomDtoEx on ChatRoomDto {
  ChatRoomModel toModel() => ChatRoomModel(
      chatRoomId: chatRoomId,
      chatRoomName: chatRoomName,
      hashtags: hashtags,
      hostUid: hostUid,
      uidList: uidList,
      createdAt: createdAt);
}
