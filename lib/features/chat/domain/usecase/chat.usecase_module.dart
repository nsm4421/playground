import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main/core/constant/response_wrapper.dart';
import '../../data/repository_impl/open_chat.repository_impl.dart';
import '../../data/repository_impl/open_chat_message.repository_impl.dart';
import '../entity/chat_message.entity.dart';
import '../entity/open_chat.entity.dart';

part "scenario/get_chat_stream.usecase.dart";

part "scenario/create_chat.usecase.dart";

part "scenario/get_open_chat_message_channel.usecase.dart";

part "scenario/send_open_chat_message.uscase.dart";

part 'scenario/fetch_open_chat_message.usecase.dart';

@lazySingleton
class ChatUseCase {
  final OpenChatRepository _openChatRepository;
  final OpenChatMessageRepository _openChatMessageRepository;

  ChatUseCase(
      {required OpenChatRepository openChatRepository,
      required OpenChatMessageRepository openChatMessageRepository})
      : _openChatRepository = openChatRepository,
        _openChatMessageRepository = openChatMessageRepository;

  GetOpenChatStreamUseCase get getOpenChatStream =>
      GetOpenChatStreamUseCase(_openChatRepository);

  CreateOpenChatUseCase get createOpenChat =>
      CreateOpenChatUseCase(_openChatRepository);

  FetchOpenChatMessageUseCase get fetchOpenChatMessages =>
      FetchOpenChatMessageUseCase( _openChatMessageRepository);

  GetOpenChatMessageChannelUseCase get openChatMessageChannel =>
      GetOpenChatMessageChannelUseCase(_openChatMessageRepository);

  SendOpenChatMessageUseCase get sendOpenChatMessage =>
      SendOpenChatMessageUseCase(
          openChatRepository: _openChatRepository,
          openChatMessageRepository: _openChatMessageRepository);
}
