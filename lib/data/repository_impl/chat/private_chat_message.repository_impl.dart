import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:portfolio/data/datasource/auth/abstract/auth.datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constant/response_wrapper.dart';
import '../../../domain/entity/chat/private_chat_message.entity.dart';
import '../../datasource/chat/impl/private_chat_message.datasource_impl.dart';
import '../../model/chat/private_chat_message/private_chat_message.model.dart';

part '../../../domain/repository/chat/private_chat_message.repository.dart';

@LazySingleton(as: PrivateChatMessageRepository)
class PrivateChatMessageRepositoryImpl implements PrivateChatMessageRepository {
  final AuthDataSource _authDataSource;
  final PrivateChatMessageDataSource _messageDataSource;

  final _logger = Logger();

  PrivateChatMessageRepositoryImpl(
      {required AuthDataSource authDataSource,
      required PrivateChatMessageDataSource messageDataSource})
      : _authDataSource = authDataSource,
        _messageDataSource = messageDataSource;

  @override
  Future<ResponseWrapper<void>> createChatMessage(
      {required String content, required String receiver}) async {
    try {
      return await _messageDataSource
          .createChatMessage(
              PrivateChatMessageModel(content: content, receiver: receiver))
          .then(ResponseWrapper.success);
    } on PostgrestException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('create message fails');
    }
  }

  @override
  Future<ResponseWrapper<void>> deleteMessageById(String messageId) async {
    try {
      return await _messageDataSource
          .deleteChatMessageById(messageId)
          .then(ResponseWrapper.success);
    } on PostgrestException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('delete message fails');
    }
  }

  @override
  Future<ResponseWrapper<List<PrivateChatMessageEntity>>> fetchLastMessages(
      DateTime afterAt) async {
    try {
      final currentUid = _authDataSource.currentUser!.id;
      return await _messageDataSource
          .fetchLastMessages(afterAt)
          .then((res) => res
              .map((e) => PrivateChatMessageEntity.fromRpcModel(e,
                  currentUid: currentUid))
              .toList())
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
  Future<ResponseWrapper<List<PrivateChatMessageEntity>>> fetchMessages(
      {required DateTime beforeAt,
      required String chatId,
      int take = 20,
      bool ascending = true}) async {
    try {
      final currentUid = _authDataSource.currentUser!.id;
      return await _messageDataSource
          .fetchMessages(
              beforeAt: beforeAt,
              chatId: chatId,
              take: take,
              ascending: ascending)
          .then((res) => res
              .map((e) => PrivateChatMessageEntity.fromWithUserModel(e,
                  currentUid: currentUid))
              .toList())
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
  RealtimeChannel getConversationChannel(
      {required String chatId,
      void Function(PrivateChatMessageEntity newRecord)? onInsert,
      void Function(PrivateChatMessageEntity oldRecord,
              PrivateChatMessageEntity newRecord)?
          onUpdate,
      void Function(PrivateChatMessageEntity oldRecord)? onDelete}) {
    return _getMessageChannel(
        key: "conversation-channel:$chatId",
        onInsert: onInsert,
        onUpdate: onUpdate,
        onDelete: onDelete);
  }

  @override
  RealtimeChannel getLastChatChannel(
      {void Function(PrivateChatMessageEntity newRecord)? onInsert,
      void Function(PrivateChatMessageEntity oldRecord,
              PrivateChatMessageEntity newRecord)?
          onUpdate,
      void Function(PrivateChatMessageEntity oldRecord)? onDelete}) {
    return _getMessageChannel(
        key: "last-message-channel:${const Uuid().v4()}",
        onInsert: onInsert,
        onUpdate: onUpdate,
        onDelete: onDelete);
  }

  RealtimeChannel _getMessageChannel(
      {required String key,
      void Function(PrivateChatMessageEntity newRecord)? onInsert,
      void Function(PrivateChatMessageEntity oldRecord,
              PrivateChatMessageEntity newRecord)?
          onUpdate,
      void Function(PrivateChatMessageEntity oldRecord)? onDelete}) {
    final currentUid = _authDataSource.currentUser!.id;
    return _messageDataSource.getMessageChannel(
        key: key,
        onInsert: onInsert == null
            ? null
            : (PrivateChatMessageModel newModel) {
                onInsert(PrivateChatMessageEntity.fromModel(newModel,
                    currentUid: currentUid));
              },
        onUpdate: onUpdate == null
            ? null
            : (PrivateChatMessageModel oldModel,
                PrivateChatMessageModel newModel) {
                onUpdate(
                    PrivateChatMessageEntity.fromModel(oldModel,
                        currentUid: currentUid),
                    PrivateChatMessageEntity.fromModel(newModel,
                        currentUid: currentUid));
              },
        onDelete: onDelete == null
            ? null
            : (PrivateChatMessageModel oldModel) {
                onDelete(PrivateChatMessageEntity.fromModel(oldModel,
                        currentUid: currentUid)
                    .copyWith(isRemoved: true));
              });
  }
}
