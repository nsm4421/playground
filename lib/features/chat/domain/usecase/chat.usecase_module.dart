import 'package:injectable/injectable.dart';
import 'package:portfolio/features/chat/data/repository_impl/private_chat_message.repository_impl.dart';
import 'package:portfolio/features/chat/domain/entity/private_chat_message.entity.dart';
import 'package:portfolio/features/chat/presentation/bloc/private_chat/chat_room/private_chat_room.bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main/core/constant/response_wrapper.dart';
import '../../data/repository_impl/open_chat.repository_impl.dart';
import '../../data/repository_impl/open_chat_message.repository_impl.dart';
import '../entity/open_chat_message.entity.dart';
import '../entity/open_chat.entity.dart';

part "scenario/get_chat_stream.usecase.dart";

part "scenario/create_chat.usecase.dart";

part "scenario/get_chat_message_channel.usecase.dart";

part "scenario/send_private_chat_message.uscase.dart";

part "scenario/send_open_chat_message.uscase.dart";

part 'scenario/fetch_chat_message.usecase.dart';

part 'scenario/delete_private_chat_message.usecase.dart';

@lazySingleton
class ChatUseCase {
  final OpenChatRepository _openChatRepository;
  final OpenChatMessageRepository _openChatMessageRepository;
  final PrivateChatMessageRepository _privateChatMessageRepository;

  ChatUseCase(
      {required OpenChatRepository openChatRepository,
      required OpenChatMessageRepository openChatMessageRepository,
      required PrivateChatMessageRepository privateChatMessageRepository})
      : _openChatRepository = openChatRepository,
        _openChatMessageRepository = openChatMessageRepository,
        _privateChatMessageRepository = privateChatMessageRepository;

  /// 채팅방 생성하기
  CreateOpenChatUseCase get createOpenChat =>
      CreateOpenChatUseCase(_openChatRepository);

  /// 스트림 가져오기
  GetOpenChatStreamUseCase get getOpenChatStream =>
      GetOpenChatStreamUseCase(_openChatRepository);

  /// 메세지 가져오기
  FetchPrivateChatMessageUseCase get fetchPrivateChatMessages =>
      FetchPrivateChatMessageUseCase(_privateChatMessageRepository);

  FetchLatestChatMessageUseCase get fetchLatestChatMessages =>
      FetchLatestChatMessageUseCase(_privateChatMessageRepository);

  FetchOpenChatMessageUseCase get fetchOpenChatMessages =>
      FetchOpenChatMessageUseCase(_openChatMessageRepository);

  /// 채널 가져오기
  GetConversationChannelUseCase get conversationChannel =>
      GetConversationChannelUseCase(_privateChatMessageRepository);

  GetLastChatChannelUseCase get lastChatChannel =>
      GetLastChatChannelUseCase(_privateChatMessageRepository);

  GetOpenChatMessageChannelUseCase get openChatMessageChannel =>
      GetOpenChatMessageChannelUseCase(_openChatMessageRepository);

  /// 메세지 보내기
  SendPrivateChatMessageUseCase get sendPrivateChatMessage =>
      SendPrivateChatMessageUseCase(_privateChatMessageRepository);

  SendOpenChatMessageUseCase get sendOpenChatMessage =>
      SendOpenChatMessageUseCase(
          openChatRepository: _openChatRepository,
          openChatMessageRepository: _openChatMessageRepository);

  /// 메세지 삭제
  DeletePrivateChatMessageEvent get deletePrivateChatMessage =>
      DeletePrivateChatMessageEvent(_privateChatMessageRepository);
}
