import 'dart:async';

import 'package:logger/logger.dart';
import 'package:portfolio/features/chat/data/model/chat_message/open_chat_message_with_user.model.dart';
import 'package:portfolio/features/main/data/datasource/base.datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../main/core/constant/supabase_constant.dart';
import '../../model/chat_message/open_chat_message.model.dart';

part "open_chat_message.datasource.dart";

part "private_chat_message.datasource.dart";

abstract interface class ChatMessageDataSource implements BaseDataSource {
  Future<void> createChatMessage(OpenChatMessageModel model);

  Future<void> deleteChatMessageById(String messageId);

  OpenChatMessageModel audit(OpenChatMessageModel model);
}

abstract class OpenChatMessageDataSource implements ChatMessageDataSource {
  Future<Iterable<OpenChatMessageWithUserModel>> fetchMessages(
      {required String chatId,
      required DateTime beforeAt,
      required int from,
      required int to,
      bool ascending = true});

  RealtimeChannel getMessageChannel(
      {required String key,
      void Function(OpenChatMessageModel newModel)? onInsert,
      void Function(OpenChatMessageModel oldModel, OpenChatMessageModel newModel)?
          onUpdate,
      void Function(OpenChatMessageModel oldModel)? onDelete});
}

abstract class PrivateChatMessageDataSource implements ChatMessageDataSource {
  Future<Iterable<OpenChatMessageWithUserModel>> fetchMessages(
      {required String chatId,
      required DateTime beforeAt,
      required int from,
      required int to,
      bool ascending = true});

  RealtimeChannel getMessageChannel(
      {required String key,
      void Function(OpenChatMessageModel newModel)? onInsert,
      void Function(OpenChatMessageModel oldModel, OpenChatMessageModel newModel)?
          onUpdate,
      void Function(OpenChatMessageModel oldModel)? onDelete});
}
