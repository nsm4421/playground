import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:portfolio/features/chat/data/model/chat_message.model.dart';
import 'package:portfolio/features/chat/domain/entity/chat_message.entity.dart';
import 'package:portfolio/features/main/core/constant/response_wrapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../datasource/chat_message/chat_message.datasource.dart';

part 'package:portfolio/features/chat/domain/repository/open_chat_message.repository.dart';

@LazySingleton(as: OpenChatMessageRepository)
class OpenChatMessageRepositoryImpl implements OpenChatMessageRepository {
  final OpenChatMessageDataSource _dataSource;
  final _logger = Logger();

  OpenChatMessageRepositoryImpl(this._dataSource);

  @override
  Future<ResponseWrapper<List<ChatMessageEntity>>> fetchMessages(
      {required String chatId,
      required DateTime beforeAt,
      required int from,
      required int to,
      bool ascending = true}) async {
    try {
      return await _dataSource
          .fetchMessages(
              chatId: chatId,
              beforeAt: beforeAt,
              from: from,
              to: to,
              ascending: ascending)
          .then((res) => res.map(ChatMessageEntity.fromModelWithUser).toList())
          .then(ResponseWrapper.success);
    } on PostgrestException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('fetch message fails');
    }
  }

  @override
  Future<ResponseWrapper<void>> createChatMessage(
      ChatMessageEntity entity) async {
    try {
      await _dataSource.createChatMessage(ChatMessageModel.fromEntity(entity));
      return ResponseWrapper.success(null);
    } on PostgrestException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('send message fails');
    }
  }

  @override
  RealtimeChannel getMessageChannel(
      {required String chatId,
      void Function(ChatMessageEntity newRecord)? onInsert,
      void Function(ChatMessageEntity oldRecord, ChatMessageEntity newRecord)?
          onUpdate,
      void Function(ChatMessageEntity oldRecord)? onDelete}) {
    return _dataSource.getMessageChannel(
      key: "open_chat_message:$chatId",
      onInsert: onInsert == null
          ? null
          : (ChatMessageModel newModel) {
              onInsert(ChatMessageEntity.fromModel(newModel));
            },
      onUpdate: onUpdate == null
          ? null
          : (ChatMessageModel oldModel, ChatMessageModel newModel) {
              onUpdate(ChatMessageEntity.fromModel(oldModel),
                  ChatMessageEntity.fromModel(newModel));
            },
      onDelete: onDelete == null
          ? null
          : (ChatMessageModel oldModel) {
              onDelete(ChatMessageEntity.fromModel(oldModel));
            },
    );
  }

  @override
  Future<ResponseWrapper<void>> deleteChatMessage(String messageId) async {
    try {
      await _dataSource.deleteChatMessageById(messageId);
      return ResponseWrapper.success(null);
    } on PostgrestException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('delete message fails');
    }
  }
}
