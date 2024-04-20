import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/domain/model/chat/private_chat/room/private_chat.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/constant/supbase.constant.dart';
import '../../../../../core/util/exeption.util.dart';
import 'remote.data_source.dart';

class RemotePrivateChatDataSourceImpl implements RemotePrivateChatDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  RemotePrivateChatDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  Stream<List<PrivateChatModel>> getChatStream() {
    try {
      final currentUid = _client.auth.currentUser?.id;
      if (currentUid == null) {
        throw const AuthException('user not login');
      }
      return _client
          .from(TableName.privateChat.name)
          .stream(primaryKey: ['id'])
          .eq('user_id', currentUid)
          .order('updated_at', ascending: false)
          .asyncMap(
              (data) async => data.map(PrivateChatModel.fromJson).toList());
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> createChat(PrivateChatModel chat) async {
    try {
      await _client.rest.from(TableName.privateChat.name).insert(chat.toJson());
      await _client.rest
          .from(TableName.privateChat.name)
          .insert(chat.swap(UuidUtil.uuid()).toJson());
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> deleteChatById(String chatId) async {
    try {
      await _client.rest
          .from(TableName.privateChat.name)
          .delete()
          .eq('id', chatId);
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }
}
