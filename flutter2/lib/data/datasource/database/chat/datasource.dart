import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/data/model/chat/create.dart';
import 'package:travel/data/model/chat/fetch.dart';

part 'datasource_impl.dart';

abstract class PrivateChatDataSource {
  Future<String?> getChatId(String opponentId);

  Future<String> create(
      {required String chatId,
      required CreatePrivateChatDto dto});

  Future<Iterable<FetchPrivateChatDto>> fetch(
      {required String beforeAt, int take = 20});

  Future<void> update(
      {required String chatId, String? lastMessage, String? lastSeen});

  Future<void> delete(String chatId);
}

abstract class PrivateMessageDataSource {
  Future<void> create(
      {required String messageId, required CreatePrivateMessageDto dto});

  Future<Iterable<FetchPrivateMessageDto>> fetch(
      {required String beforeAt, required String chatId, int take = 20});

  Future<void> delete(String messageId);
}
