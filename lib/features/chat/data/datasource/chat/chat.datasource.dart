import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../main/core/constant/supabase_constant.dart';
import '../../../../main/data/datasource/base.datasource.dart';
import '../../model/chat/open_chat.model.dart';

part "open_chat.datasource.dart";

abstract interface class ChatDataSource<T> implements BaseDataSource {
  Future<void> createChat(T chatRoom);

  T audit(T model);

  Future<void> updateLastMessage(
      {required String chatId, required String lastMessage});

  Stream<Iterable<T>> get chatStream;
}

abstract interface class OpenChatDataSource
    implements ChatDataSource<OpenChatModel> {}
