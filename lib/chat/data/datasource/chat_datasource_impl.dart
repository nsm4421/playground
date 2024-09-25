import 'package:flutter_app/chat/data/dto/chat.dto.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  Future<Iterable<FetchChatDto>> fetchChats(
      {required DateTime beforeAt, int take = 20}) async {
    try {
      return await _supabaseClient.rpc(RpcFunctions.fetchChats.name, params: {
        'before_at': beforeAt,
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
  Future<void> createChat(CreateChatDto dto) async {
    try {
      return await _supabaseClient.rest.from(Tables.chats.name).insert(dto
          .copyWith(created_at: dto.created_at ?? DateTime.now().toUtc())
          .toJson());
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
}
