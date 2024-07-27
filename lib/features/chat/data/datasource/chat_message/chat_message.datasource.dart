import 'package:logger/logger.dart';
import 'package:portfolio/features/main/data/datasource/base.datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../main/core/constant/supabase_constant.dart';
import '../../model/chat_message.model.dart';

part "open_chat_message.datasource.dart";

abstract interface class ChatMessageDataSource implements BaseDataSource{
  Future<void> createChatMessage(ChatMessageModel model);

  Future<void> deleteChatMessageById(String messageId);

  ChatMessageModel audit(ChatMessageModel model);
}

abstract class OpenChatMessageDataSource implements ChatMessageDataSource {
  RealtimeChannel getMessageChannel(
      {required String key,
      void Function(ChatMessageModel newModel)? onInsert,
      void Function(ChatMessageModel oldModel, ChatMessageModel newModel)?
          onUpdate,
      void Function(ChatMessageModel oldModel)? onDelete});
}
