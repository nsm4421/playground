import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/domain/model/chat/private_chat/room/private_chat.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/constant/supbase.constant.dart';
import '../../../../../core/util/exeption.util.dart';
import '../../../../../domain/model/user/user.model.dart';
import 'remote.data_source.dart';

class RemotePrivateChatDataSourceImpl implements RemotePrivateChatDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  RemotePrivateChatDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  Future<PrivateChatModel> getChatByUser(
      {required UserModel currentUser, required UserModel opponentUser}) async {
    try {
      // 유저 정보로 이미 채팅방이 존재하는지 조회
      final res = await _client.rest
          .from(TableName.privateChat.name)
          .select()
          .eq('user_id', currentUser.id)
          .eq('opponent_id', opponentUser.id)
          .limit(1)
          .then((res) =>
              res.map((json) => PrivateChatModel.fromJson(json)).toList());
      // 채팅방이 존재하는 경우 존재하는 채팅방 return
      if (res.isNotEmpty) {
        return res.first;
      }
      // 채팅방이 없는 경우 신규 생성
      final chat = PrivateChatModel.newFromUsers(
          currentUser: currentUser, opponentUser: opponentUser);
      await createChat(chat);
      return chat;
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

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
          .insert(chat.swap().toJson());
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
