import 'package:injectable/injectable.dart';
import 'package:my_app/data/entity/user/account.entity.dart';
import 'package:my_app/domain/usecase/module/chat/open_chat.usecase.dart';
import 'package:my_app/presentation/bloc/chat/create_open_chat/create_open_chat.cubit.dart';
import 'package:my_app/presentation/bloc/chat/display_open_chat_message/display_open_chat_message.bloc.dart';
import 'package:my_app/presentation/bloc/chat/send_private_chat_message/send_private_chat_message.cubit.dart';

import '../../../data/entity/chat/open_chat/open_chat.entity.dart';
import '../../../domain/usecase/module/chat/open_chat_message.usecase.dart';
import '../../../domain/usecase/module/chat/private_chat_message.usecase.dart';
import 'display_open_chat/display_open_chat.bloc.dart';
import 'send_open_chat_message/send_open_chat_message.cubit.dart';

@lazySingleton
class ChatBloc {
  final OpenChatUseCase _openChatUseCase;
  final OpenChatMessageUseCase _openChatMessageUseCase;
  final PrivateChatMessageUseCase _privateChatMessageUseCase;

  ChatBloc(
      {required OpenChatUseCase openChatUseCase,
      required OpenChatMessageUseCase openChatMessageUseCase,
      required PrivateChatMessageUseCase privateChatMessageUseCase})
      : _openChatUseCase = openChatUseCase,
        _openChatMessageUseCase = openChatMessageUseCase,
        _privateChatMessageUseCase = privateChatMessageUseCase;

  @lazySingleton
  DisplayOpenChatBloc get displayOpenChat => DisplayOpenChatBloc(
      openChatUseCase: _openChatUseCase,
      openChatMessageUseCase: _openChatMessageUseCase);

  @lazySingleton
  CreateOpenChatCubit get createOpenChat =>
      CreateOpenChatCubit(_openChatUseCase);

  @injectable
  DisplayOpenChatMessageBloc displayOpenChatMessage(OpenChatEntity openChat) =>
      DisplayOpenChatMessageBloc(openChat,
          openChatUseCase: _openChatUseCase,
          openChatMessageUseCase: _openChatMessageUseCase);

  @injectable
  SendOpenChatMessageCubit sendOpenChatMessage(OpenChatEntity openChat) =>
      SendOpenChatMessageCubit(openChat,
          chatUseCase: _openChatUseCase,
          messageUseCase: _openChatMessageUseCase);

  @lazySingleton
  SendPrivateChatMessageCubit get sendPrivateChat =>
      SendPrivateChatMessageCubit(_privateChatMessageUseCase);
}
