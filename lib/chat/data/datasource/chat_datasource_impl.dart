import 'package:flutter_app/chat/data/dto/chat.dto.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/shared.export.dart';
import '../dto/chat_message.dto.dart';

part 'chat_datasource.dart';

class ChatDataSourceImpl extends ChatDataSource {
  final SupabaseClient _supabaseClient;
  final Logger _logger;

  ChatDataSourceImpl(
      {required SupabaseClient supabaseClient, required Logger logger})
      : _supabaseClient = supabaseClient,
        _logger = logger;

  @override
  Future<FetchChatDto> findChatByUidOrElseCreate(String opponentUid) async {
    try {
      // 상대방 uid로 채팅방 조회하기
      final fetched = await _supabaseClient
          .rpc<List<Map<String, dynamic>>>(RpcFunctions.fetchChatByOpponentUid.name,
              params: {'opponent_uid_to_find': opponentUid})
          .then((res) => res.map((json) => FetchChatDto.fromJson(json)))
          .then((res) => res.firstOrNull);
      if (fetched != null) return fetched;
      // 채팅방이 존재하지 않는 경우, 새로 개설한 채팅방을 return
      final dto = CreateChatDto(
          id: const Uuid().v4(),
          uid: _supabaseClient.auth.currentUser!.id,
          opponent_uid: opponentUid,
          created_at: DateTime.now().toUtc());
      final chatId = await createChat(dto);
      return findChatById(chatId);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<FetchChatDto> findChatById(String chatId) async {
    try {
      return await _supabaseClient
          .rpc<List<Map<String, dynamic>>>(RpcFunctions.fetchChatById.name,
              params: {'chat_id_to_fetch': chatId})
          .then((res) => res.map((json) => FetchChatDto.fromJson(json)))
          .then((res) => res.first);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<Iterable<FetchChatDto>> fetchChats(
      {required DateTime beforeAt, int take = 20}) async {
    try {
      return await _supabaseClient.rpc<List<Map<String, dynamic>>>(
          RpcFunctions.fetchChats.name,
          params: {
            'before_at': beforeAt.toUtc(),
            'take': take
          }).then((res) => res.map((json) => FetchChatDto.fromJson(json)));
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<Iterable<FetchChatMessageDto>> fetchMessages(
      {required String chatId,
      required DateTime beforeAt,
      int take = 20}) async {
    try {
      return await _supabaseClient
          .rpc(RpcFunctions.fetchChatMessages.name, params: {
        'chat_id_to_fetch': chatId,
        'before_at': beforeAt,
        'take': take
      }).then((res) => res.map((json) => FetchChatMessageDto.fromJson(json)));
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<String> createChat(CreateChatDto dto) async {
    try {
      return await _supabaseClient.rest
          .from(Tables.chats.name)
          .insert(dto
              .copyWith(created_at: dto.created_at ?? DateTime.now().toUtc())
              .toJson())
          .then((_) => dto.id);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<void> createMessage(CreateChatMessageDto dto) async {
    try {
      return await _supabaseClient.rest.from(Tables.chatMessages.name).insert(
          dto
              .copyWith(created_at: dto.created_at ?? DateTime.now().toUtc())
              .toJson());
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<void> deleteChat(String chatId) async {
    try {
      return await _supabaseClient.rest
          .from(Tables.chats.name)
          .delete()
          .eq('chat_id', chatId);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<void> deleteMessageById(String messageId) async {
    try {
      return await _supabaseClient.rest
          .from(Tables.chatMessages.name)
          .delete()
          .eq('id', messageId);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<void> deleteMessageByChat(String chatId) async {
    try {
      return await _supabaseClient.rest
          .from(Tables.chatMessages.name)
          .delete()
          .eq('chat_id', chatId);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<void> updateIsSeen(String messageId) async {
    try {
      return await _supabaseClient.rest
          .from(Tables.chatMessages.name)
          .update({'is_seen': true}).eq('id', messageId);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }
}
