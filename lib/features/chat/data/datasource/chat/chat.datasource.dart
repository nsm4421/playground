import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../main/core/constant/supabase_constant.dart';
import '../../../../main/data/datasource/base.datasource.dart';
import '../../model/chat_message.model.dart';
import '../../model/open_chat.model.dart';

part "open_chat.datasource.dart";

abstract interface class ChatDataSource<T> implements BaseDataSource {
  Future<void> createChat(T chatRoom);

  T audit(T model);
}

abstract interface class OpenChatDataSource
    implements ChatDataSource<OpenChatModel> {
  Stream<Iterable<OpenChatModel>> get chatStream;

  Future<void> updateLastMessage(
      {required String chatId, required String lastMessage});
}
