import 'package:flutter_app/auth/auth.export.dart';
import 'package:flutter_app/chat/constant/chat_type.dart';
import 'package:flutter_app/chat/data/datasource/chat_datasource_impl.dart';
import 'package:flutter_app/chat/data/dto/chat.dto.dart';
import 'package:flutter_app/chat/data/dto/chat_message.dto.dart';
import 'package:flutter_app/chat/domain/entity/chat.entity.dart';
import 'package:flutter_app/chat/domain/entity/chat_message.entity.dart';
import 'package:flutter_app/shared/constant/constant.export.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

part 'repository.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl extends ChatRepository {
  final ChatDataSource _chatDataSource;
  final Logger _logger = Logger();

  ChatRepositoryImpl(this._chatDataSource);

  @override
  Future<ResponseWrapper<List<ChatEntity>>> fetchChats(
      {required DateTime beforeAt, int take = 20}) async {
    try {
      return await _chatDataSource
          .fetchChats(beforeAt: beforeAt, take: take)
          .then((res) => res.map(ChatEntity.from).toList())
          .then(SuccessResponse.from);
    } on CustomException catch (error) {
      _logger.e(error);
      return ErrorResponse.from(error);
    }
  }

  @override
  Future<ResponseWrapper<List<ChatMessageEntity>>> fetchChatMessages(
      {required String chatId,
      required DateTime beforeAt,
      int take = 20}) async {
    try {
      return await _chatDataSource
          .fetchMessages(chatId: chatId, beforeAt: beforeAt, take: take)
          .then((res) => res.map(ChatMessageEntity.from).toList())
          .then(SuccessResponse.from);
    } on CustomException catch (error) {
      _logger.e(error);
      return ErrorResponse.from(error);
    }
  }

  @override
  Future<ResponseWrapper<void>> createChat(
      {required String currentUid, required String opponentUid}) async {
    try {
      final messageId = const Uuid().v4();
      final dto = CreateChatDto(
          id: messageId, uid: currentUid, opponent_uid: opponentUid);
      await _chatDataSource.createChat(dto);
      await _chatDataSource
          .createChat(dto.copyWith(uid: opponentUid, opponent_uid: currentUid));
      return const SuccessResponse<void>();
    } on CustomException catch (error) {
      _logger.e(error);
      return ErrorResponse.from(error);
    }
  }

  @override
  Future<ResponseWrapper<void>> createChatMessage(
      {required String chatId,
      required ChatMessageType type,
      required String content,
      required String currentUid,
      required String opponentUid}) async {
    try {
      final messageId = const Uuid().v4();
      final dto = CreateChatMessageDto(
          id: messageId,
          uid: currentUid,
          type: type,
          content: content,
          is_seen: false,
          sender_uid: currentUid,
          receiver_uid: opponentUid);
      await _chatDataSource.createMessage(dto);
      await _chatDataSource.createMessage(dto.copyWith(uid: opponentUid));
      return const SuccessResponse<void>();
    } on CustomException catch (error) {
      _logger.e(error);
      return ErrorResponse.from(error);
    }
  }

  @override
  Future<ResponseWrapper<void>> deleteChat(String chatId) async {
    try {
      await _chatDataSource.deleteChat(chatId); // 채팅방 삭제
      await _chatDataSource.deleteMessageByChat(chatId); // 메세지 삭제
      return const SuccessResponse<void>();
    } on CustomException catch (error) {
      _logger.e(error);
      return ErrorResponse.from(error);
    }
  }

  @override
  Future<ResponseWrapper<void>> deleteChatMessage(String messageId) async {
    try {
      return await _chatDataSource
          .deleteMessageById(messageId)
          .then((_) => const SuccessResponse<void>());
    } on CustomException catch (error) {
      _logger.e(error);
      return ErrorResponse.from(error);
    }
  }
}
