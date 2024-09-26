import 'dart:developer';

import 'package:flutter_app/chat/constant/chat_type.dart';
import 'package:flutter_app/chat/domain/entity/chat.entity.dart';
import 'package:flutter_app/chat/domain/entity/chat_message.entity.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/shared.export.dart';
import '../../data/repository/repository_impl.dart';

part 'scenario/fetch_chats.dart';

part 'scenario/send_dm.dart';

part 'scenario/delete_chat.dart';

part 'scenario/message_seen.dart';

@lazySingleton
class ChatUseCase {
  final ChatRepository _repository;

  ChatUseCase(this._repository);

  FindChatByIdUseCase get findChatById => FindChatByIdUseCase(_repository);

  FetchChatsUseCase get fetchChats => FetchChatsUseCase(_repository);

  FetchChatMessagesUseCase get fetchChatMessages =>
      FetchChatMessagesUseCase(_repository);

  FetchChatMessagesUseCase get sendChatMessage =>
      FetchChatMessagesUseCase(_repository);

  SendDmUseCase get sendDM => SendDmUseCase(_repository);

  DeleteChatUseCase get deleteChat => DeleteChatUseCase(_repository);

  DeleteChatMessageUseCase get deleteChatMessage =>
      DeleteChatMessageUseCase(_repository);

  SeeChatMessageUseCase get seeChatMessage =>
      SeeChatMessageUseCase(_repository);
}
