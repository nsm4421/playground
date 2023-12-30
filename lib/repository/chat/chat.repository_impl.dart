import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/domain/dto/chat/chat.dto.dart';
import 'package:my_app/domain/dto/chat/message.dto.dart';
import 'package:my_app/domain/dto/user/user.dto.dart';
import 'package:my_app/domain/model/chat/chat.model.dart';
import 'package:my_app/domain/model/chat/message.model.dart';
import 'package:uuid/uuid.dart';

import '../../api/auth/auth.api.dart';
import '../../api/chat/chat.api.dart';
import '../../core/constant/chat.enum.dart';
import '../../core/response/response.dart';
import 'chat.repository.dart';

@Singleton(as: ChatRepository)
class ChatRepositoryImpl extends ChatRepository {
  final AuthApi _authApi;
  final ChatApi _chatApi;

  ChatRepositoryImpl({required AuthApi authApi, required ChatApi chatApi})
      : _authApi = authApi,
        _chatApi = chatApi;

  @override
  Future<Response<String>> getDirectMessageChatId(String opponentUid) async {
    try {
      return Response<String>(
          status: Status.success,
          data: await _chatApi.getDirectMessageChatId(opponentUid));
    } catch (err) {
      debugPrint(err.toString());
      return Response<String>(status: Status.error, message: err.toString());
    }
  }

  @override
  Future<Stream<List<MessageModel>>> getMessageStreamByChatId(
          String chatId) async =>
      await _chatApi.getMessageStreamByChatId(chatId);

  @override
  Future<Response<void>> sendMessage(
      {required String chatId,
      required MessageType type,
      required String content}) async {
    try {
      await _chatApi.sendMessage(MessageDto(
          chatId: chatId,
          messageId: const Uuid().v1(),
          content: content,
          type: type,
          createdAt: DateTime.now()));
      await _chatApi.updateLastSeen(chatId);

      return const Response<void>(status: Status.success);
    } catch (err) {
      debugPrint(err.toString());
      return Response<void>(status: Status.error, message: err.toString());
    }
  }
}
