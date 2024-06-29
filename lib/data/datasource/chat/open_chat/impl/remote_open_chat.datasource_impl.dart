import 'package:logger/logger.dart';
import 'package:my_app/domain/model/chat/base/open_chat.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/constant/database.constant.dart';
import '../../../../../core/exception/custom_exception.dart';
import '../abstract/open_chat.datasource.dart';

part '../abstract/remote_open_chat.datasource.dart';

class RemoteOpenChatDataSourceImpl implements RemoteOpenChatDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  static const _orderByField = "createdAt";

  RemoteOpenChatDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  // 현재 로그인 유저의 id
  String get _getCurrentUidOrElseThrow {
    final currentUid = _client.auth.currentUser?.id;
    if (currentUid == null) {
      throw const AuthException('NOT LOGIN');
    }
    return currentUid;
  }

  @override
  Stream<Iterable<OpenChatModel>> get chatStream => _client
      .from(TableName.openChat.name)
      .stream(primaryKey: ['id'])
      .order(_orderByField, ascending: false)
      .asyncMap((event) => event.map(OpenChatModel.fromJson));

  @override
  Future<void> saveChat(OpenChatModel model) async {
    try {
      return await _client.rest.from(TableName.openChat.name).insert(model
          .copyWith(
              createdBy: _getCurrentUidOrElseThrow, createdAt: DateTime.now())
          .toJson());
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> modifyChat(String chatId,
      {String? title, DateTime? lastTalkAt, String? lastMessage}) async {
    try {
      return await _client.rest.from(TableName.openChat.name).update({
        if (title != null) 'title': title,
        if (lastTalkAt != null) 'lastTalkAt': lastTalkAt.toIso8601String(),
        if (lastMessage != null) 'lastMessage': lastMessage,
      }).eq("id", chatId);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> deleteChatById(String chatId) async {
    try {
      return await _client.rest
          .from(TableName.openChat.name)
          .delete()
          .eq("id", chatId);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }
}
