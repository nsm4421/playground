import 'package:injectable/injectable.dart';
import 'package:my_app/core/utils/logging/custom_logger.dart';
import 'package:my_app/core/utils/response_wrappper/response_wrapper.dart';
import 'package:my_app/data/data_source/remote/chat/chat.api.dart';
import 'package:my_app/data/mapper/chat_message_mapper.dart';
import 'package:my_app/data/mapper/chat_room_mapper.dart';
import 'package:my_app/domain/model/chat/chat_message/chat_message.model.dart';
import 'package:my_app/domain/repository/chat.repository.dart';

import '../../core/constant/enums/status.enum.dart';
import '../../domain/model/chat/chat_room/chat_room.model.dart';

@Singleton(as: ChatRepository)
class ChatRepositoryImpl extends ChatRepository {
  final ChatApi _chatApi;

  ChatRepositoryImpl(this._chatApi);

  @override
  Future<ResponseWrapper<void>> createChatRoom(
      {required String chatRoomName, required List<String> hashtags}) async {
    try {
      await _chatApi.createChatRoom(
          chatRoomName: chatRoomName, hashtags: hashtags);
      return const ResponseWrapper(status: ResponseStatus.success);
    } catch (err) {
      CustomLogger.logger.e(err);
      return const ResponseWrapper(
          status: ResponseStatus.error, message: "Fail to create chat room");
    }
  }

  @override
  Future<ResponseWrapper<ChatRoomModel?>> getChatRoomById(
      String chatRoomId) async {
    try {
      final chatRoom = await _chatApi.getChatRoomById(chatRoomId);
      return ResponseWrapper(
          status: ResponseStatus.success, data: chatRoom.toModel());
    } catch (err) {
      CustomLogger.logger.e(err);
      return const ResponseWrapper(
          status: ResponseStatus.error, message: "Fail to get chat room");
    }
  }

  @override
  Future<ResponseWrapper<List<ChatRoomModel>>> getChatRooms() async {
    try {
      final chatRooms =
          (await _chatApi.getChatRooms()).map((e) => e.toModel()).toList();
      return ResponseWrapper(status: ResponseStatus.success, data: chatRooms);
    } catch (err) {
      CustomLogger.logger.e(err);
      return const ResponseWrapper(
          status: ResponseStatus.error,
          message: "Fail to get chat rooms",
          data: []);
    }
  }

  @override
  Future<ResponseWrapper<List<ChatMessageModel>>> getChatMessages(
      String chatRoomId) async {
    try {
      final messages = (await _chatApi.getChatMessages(chatRoomId))
          .map((e) => e.toModel())
          .toList();
      return ResponseWrapper(status: ResponseStatus.success, data: messages);
    } catch (err) {
      CustomLogger.logger.e(err);
      return const ResponseWrapper(
          status: ResponseStatus.error,
          message: "Fail to get chat messages",
          data: []);
    }
  }

  @override
  Future<ResponseWrapper<ChatMessageModel>> sendChatMessage(
      {required String chatRoomId, required String message}) async {
    try {
      final chatMessageDto = await _chatApi.sendChatMessage(
          chatRoomId: chatRoomId, message: message);
      return ResponseWrapper(
          status: ResponseStatus.success, data: chatMessageDto.toModel());
    } catch (err) {
      CustomLogger.logger.e(err);
      return const ResponseWrapper(
          status: ResponseStatus.error, message: "Fail to send message");
    }
  }

  @override
  Future<ResponseWrapper<void>> modifyChatRoom(
      {required String chatRoomId,
      required String chatRoomName,
      required List<String> hashtags}) async {
    try {
      await _chatApi.modifyChatRoom(
          chatRoomId: chatRoomId,
          chatRoomName: chatRoomName,
          hashtags: hashtags);
      return const ResponseWrapper(status: ResponseStatus.success);
    } catch (err) {
      CustomLogger.logger.e(err);
      return const ResponseWrapper(
          status: ResponseStatus.error, message: "Fail to modify chat room");
    }
  }

  @override
  Future<ResponseWrapper<void>> deleteChatRoom(String chatRoomId) async {
    try {
      await _chatApi.deleteChatRoom(chatRoomId);
      return const ResponseWrapper(status: ResponseStatus.success);
    } catch (err) {
      CustomLogger.logger.e(err);
      return const ResponseWrapper(
          status: ResponseStatus.error, message: "Fail to delete chat room");
    }
  }

  @override
  Stream<List<ChatRoomModel>> getChatRoomStream() =>
      _chatApi.getChatRoomStream();

  @override
  Stream<List<ChatMessageModel>> getChatMessageStream(String chatRoomId) =>
      _chatApi.getChatMessageStream(chatRoomId);

  @override
  Future<ResponseWrapper<void>> enterChatRoom(String chatRoomId) async {
    try {
      await _chatApi.enterChatRoom(chatRoomId);
      return const ResponseWrapper(status: ResponseStatus.success);
    } catch (err) {
      return const ResponseWrapper(
          status: ResponseStatus.error, message: "Fail to delete chat room");
    }
  }

  @override
  Future<ResponseWrapper<void>> leaveChatRoom(String chatRoomId) async {
    try {
      await _chatApi.leaveChatRoom(chatRoomId);
      return const ResponseWrapper(status: ResponseStatus.success);
    } catch (err) {
      return const ResponseWrapper(
          status: ResponseStatus.error, message: "Fail to delete chat room");
    }
  }
}
