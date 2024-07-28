import 'dart:async';

import 'package:logger/logger.dart';
import 'package:portfolio/features/chat/data/model/chat_message/open_chat_message_with_user.model.dart';
import 'package:portfolio/features/chat/data/model/chat_message/private_chat_message.model.dart';
import 'package:portfolio/features/main/data/datasource/base.datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../main/core/constant/supabase_constant.dart';
import '../../model/chat_message/open_chat_message.model.dart';
import '../../model/chat_message/private_chat_message_with_user.model.dart';

part "open_chat_message.datasource.dart";

part "private_chat_message.datasource.dart";

abstract interface class ChatMessageDataSource<T> implements BaseDataSource {
  Future<void> createChatMessage(T model);

  Future<void> deleteChatMessageById(String messageId);

  T audit(T model);

  RealtimeChannel getMessageChannel(
      {required String key,
      void Function(T newModel)? onInsert,
      void Function(T oldModel, T newModel)? onUpdate,
      void Function(T oldModel)? onDelete});
}

abstract class OpenChatMessageDataSource
    implements ChatMessageDataSource<OpenChatMessageModel> {
  Future<Iterable<OpenChatMessageWithUserModel>> fetchMessages(
      {required String chatId,
      required DateTime beforeAt,
      required int from,
      required int to,
      bool ascending = true});
}

abstract class PrivateChatMessageDataSource
    implements ChatMessageDataSource<PrivateChatMessageModel> {
  String getChatId(String receiver, {String? sender});

  Future<Iterable<PrivateChatMessageWithUserModelForRpc>> fetchLastMessages(
      DateTime afterAt);

  Future<Iterable<PrivateChatMessageWithUserModel>> fetchMessages(
      {required DateTime beforeAt,
      required String receiver,
      int take = 20,
      bool ascending = true});
}
