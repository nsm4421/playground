import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:my_app/domain/model/chat/message/local_private_chat_message.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constant/database.constant.dart';
import '../../../../core/exception/custom_exception.dart';
import '../../../../domain/model/chat/message/private_chat_message.model.dart';

part 'private_chat_message.datasource.dart';

class LocalPrivateChatMessageDataSourceImpl
    implements LocalPrivateChatMessageDataSource {
  final String _boxName;
  final Logger _logger;

  LocalPrivateChatMessageDataSourceImpl(
      {required String boxName, required Logger logger})
      : _boxName = boxName,
        _logger = logger;

  Future<Box<LocalPrivateChatMessageModel>> get _$box async =>
      await Hive.openBox<LocalPrivateChatMessageModel>(_boxName);

  @override
  Future<void> deleteMessageById(String messageId) async {
    try {
      return await (await _$box).delete(messageId);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> saveChatMessage(LocalPrivateChatMessageModel model) async {
    try {
      return await (await _$box).put(model.id, model);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }
}

class RemotePrivateChatMessageDataSourceImpl
    implements RemotePrivateChatMessageDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  RemotePrivateChatMessageDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  static const String _orderByField = "createdAt";

  // 현재 로그인 유저의 id
  String get _getCurrentUidOrElseThrow {
    final currentUid = _client.auth.currentUser?.id;
    if (currentUid == null) {
      throw const AuthException('NOT LOGIN');
    }
    return currentUid;
  }

  @override
  Future<void> deleteMessageById(String messageId) async {
    try {
      return await _client.rest
          .from(TableName.privateChatMessage.name)
          .delete()
          .eq("id", messageId);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> saveChatMessage(PrivateChatMessageModel model) async {
    try {
      print(model);
      return await _client.rest.from(TableName.privateChatMessage.name).insert(
          model
              .copyWith(
                  id: model.id.isEmpty ? const Uuid().v4() : model.id,
                  senderUid: _getCurrentUidOrElseThrow,
                  createdAt: model.createdAt ?? DateTime.now())
              .toJson());
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }
}
