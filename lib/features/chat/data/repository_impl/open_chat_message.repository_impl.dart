import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:portfolio/features/chat/data/model/open_chat_message/open_chat_message.model.dart';
import 'package:portfolio/features/chat/domain/entity/open_chat_message.entity.dart';
import 'package:portfolio/features/main/core/constant/response_wrapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../datasource/open_chat_message/open_chat_message.datasource_impl.dart';

part 'package:portfolio/features/chat/domain/repository/open_chat_message.repository.dart';

@LazySingleton(as: OpenChatMessageRepository)
class OpenChatMessageRepositoryImpl implements OpenChatMessageRepository {
  final OpenChatMessageDataSource _dataSource;
  final _logger = Logger();

  OpenChatMessageRepositoryImpl(this._dataSource);

  @override
  Future<ResponseWrapper<List<OpenChatMessageEntity>>> fetchMessages(
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
          .then((res) =>
              res.map(OpenChatMessageEntity.fromModelWithUser).toList())
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
      OpenChatMessageEntity entity) async {
    try {
      await _dataSource
          .createChatMessage(OpenChatMessageModel.fromEntity(entity));
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
      void Function(OpenChatMessageEntity newRecord)? onInsert,
      void Function(
              OpenChatMessageEntity oldRecord, OpenChatMessageEntity newRecord)?
          onUpdate,
      void Function(OpenChatMessageEntity oldRecord)? onDelete}) {
    return _dataSource.getMessageChannel(
      key: "open_chat_message:$chatId",
      onInsert: onInsert == null
          ? null
          : (OpenChatMessageModel newModel) {
              onInsert(OpenChatMessageEntity.fromModel(newModel));
            },
      onUpdate: onUpdate == null
          ? null
          : (OpenChatMessageModel oldModel, OpenChatMessageModel newModel) {
              onUpdate(OpenChatMessageEntity.fromModel(oldModel),
                  OpenChatMessageEntity.fromModel(newModel));
            },
      onDelete: onDelete == null
          ? null
          : (OpenChatMessageModel oldModel) {
              onDelete(OpenChatMessageEntity.fromModel(oldModel));
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
