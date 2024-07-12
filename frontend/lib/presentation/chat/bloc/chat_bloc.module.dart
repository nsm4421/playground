import 'package:hot_place/domain/usecase/chat/message/open_chat_messsage.usecase.dart';
import 'package:hot_place/domain/usecase/chat/message/private_chat_message.usecase.dart';
import 'package:hot_place/domain/usecase/chat/room/open_chat.usecase.dart';
import 'package:hot_place/presentation/chat/bloc/message/open_chat/open_chat_message.bloc.dart';
import 'package:hot_place/presentation/chat/bloc/message/private_chat/private_chat_message.bloc.dart';
import 'package:hot_place/presentation/chat/bloc/room/open_chat/open_chat.bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecase/chat/room/private_chat.usecase.dart';

@lazySingleton
class ChatBlocModule {
  final OpenChatUseCase _openChatUseCase;
  final OpenChatMessageUseCase _openChatMessageUseCase;
  final PrivateChatUseCase _privateChatUseCase;
  final PrivateChatMessageUseCase _privateChatMessageUseCase;

  ChatBlocModule(
      {required OpenChatUseCase openChatUseCase,
      required PrivateChatUseCase privateChatUseCase,
      required OpenChatMessageUseCase openChatMessageUseCase,
      required PrivateChatMessageUseCase privateChatMessageUseCase})
      : _openChatUseCase = openChatUseCase,
        _privateChatUseCase = privateChatUseCase,
        _openChatMessageUseCase = openChatMessageUseCase,
        _privateChatMessageUseCase = privateChatMessageUseCase;

  @injectable
  OpenChatBloc get openChatBloc => OpenChatBloc(useCase: _openChatUseCase);

  @injectable
  OpenChatMessageBloc openChatMessageBloc(@factoryParam String chatId) =>
      OpenChatMessageBloc(
          chatId: chatId,
          chatUseCase: _openChatUseCase,
          messageUseCase: _openChatMessageUseCase);

  @injectable
  PrivateChatMessageBloc privateChatMessageBloc(@factoryParam String chatId) =>
      PrivateChatMessageBloc(
          chatId: chatId,
          chatUseCase: _privateChatUseCase,
          messageUseCase: _privateChatMessageUseCase);
}
