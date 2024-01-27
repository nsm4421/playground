import 'package:my_app/domain/model/chat/chat_message/chat_message.model.dart';
import 'package:my_app/domain/model/chat/chat_room/chat_room.model.dart';
import 'package:my_app/domain/repository/repository.dart';

import '../../core/utils/response_wrappper/response_wrapper.dart';

abstract class ChatRepository extends Repository {
  Future<ResponseWrapper<void>> createChatRoom(
      {required String chatRoomName, required List<String> hashtags});

  Future<ResponseWrapper<ChatRoomModel?>> getChatRoomById(String chatRoomId);

  Future<ResponseWrapper<List<ChatRoomModel>>> getChatRooms();

  Future<ResponseWrapper<void>> enterChatRoom(String chatRoomId);

  Future<ResponseWrapper<void>> leaveChatRoom(String chatRoomId);

  Future<ResponseWrapper<void>> modifyChatRoom(
      {required String chatRoomId,
      required String chatRoomName,
      required List<String> hashtags});

  Future<ResponseWrapper<void>> deleteChatRoom(String chatRoomId);

  Future<ResponseWrapper<List<ChatMessageModel>>> getChatMessages(
      String chatRoomId);

  Future<ResponseWrapper<ChatMessageModel>> sendChatMessage(
      {required String chatRoomId, required String message});

  Stream<List<ChatRoomModel>> getChatRoomStream();

  Stream<List<ChatMessageModel>> getChatMessageStream(String chatRoomId);
}
