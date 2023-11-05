import 'package:my_app/domain/model/chat/chat_message/chat_message.model.dart';
import 'package:my_app/domain/model/chat/chat_room/chat_room.model.dart';
import 'package:my_app/domain/repository/repository.dart';

import '../../core/utils/response_wrappper/response_wrapper.dart';

abstract class ChatRepository extends Repository {
  Future<ResponseWrapper<void>> createChatRoom(
      {required String chatRoomName, required List<String> hashtags});

  Future<ResponseWrapper<ChatRoomModel?>> getChatRoomById(String chatRoomId);

  Future<ResponseWrapper<List<ChatRoomModel>?>> getChatRooms();

  Future<ResponseWrapper<List<ChatMessageModel>?>> getChatMessages(
      String chatRoomId);

  ResponseWrapper<Stream<List<ChatMessageModel>>?> getChatMessageStream(
      String chatRoomId);
}
