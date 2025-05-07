import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constant/response_wrapper.dart';
import '../../../core/util/exception.util.dart';
import '../../../domain/entity/chat/open_chat_message.entity.dart';
import '../../datasource/remote/chat/impl/open_chat_message.remote_datasource_impl.dart';
import '../../model/chat/open_chat_message/open_chat_message.model.dart';

part '../../../domain/repository/chat/open_chat_message.repository.dart';

@LazySingleton(as: OpenChatMessageRepository)
class OpenChatMessageRepositoryImpl implements OpenChatMessageRepository {
  final OpenChatMessageRemoteDataSource _dataSource;
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
    } catch (error) {
      throw CustomException.from(error);
    }
  }

  @override
  Future<ResponseWrapper<void>> createChatMessage(
      OpenChatMessageEntity entity) async {
    try {
      await _dataSource
          .createChatMessage(OpenChatMessageModel.fromEntity(entity));
      return ResponseWrapper.success(null);
    } catch (error) {
      throw CustomException.from(error);
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
    try {
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
    } catch (error) {
      throw CustomException.from(error);
    }
  }

  @override
  Future<ResponseWrapper<void>> deleteChatMessage(String messageId) async {
    try {
      await _dataSource.deleteChatMessageById(messageId);
      return ResponseWrapper.success(null);
    } catch (error) {
      throw CustomException.from(error);
    }
  }
}
