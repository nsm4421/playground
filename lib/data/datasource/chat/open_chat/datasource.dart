import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/util/util.dart';
import 'package:travel/data/model/chat/create_chat_message.dart';
import 'package:travel/data/model/chat/fetch_chat_message.dart';
import 'package:travel/data/model/chat/fetch_chat_room.dart';
import 'package:uuid/uuid.dart';

import '../../../model/chat/create_chat_room.dart';
import '../../../model/chat/edit_chat_room.dart';

part 'datasource_impl.dart';

abstract interface class OpenChatRoomDataSource {
  Future<String> createChatRoom(CreateOpenChatModel model);

  Future<Iterable<FetchOpenChatModel>> fetchChatRooms(DateTime beforeAt,
      {int take = 20});

  Future<void> editChatRoom(EditOpenChatModel model); // 방제목, 해시태그 수정

  Future<void> editChatRoomMetaData(EditOpenChatMetaDataModel model);

  Future<void> deleteChatRoom(String id);
}

abstract interface class OpenChatMessageDataSource {
  Future<String> createChatMessage(CreateOpenChatMessageModel model);

  Future<Iterable<FetchOpenChatMessageModel>> fetchChatMessages(
      {required String chatId, required DateTime beforeAt, int take = 20});

  Future<void> softDeleteChatMessage(String messageId);
}
