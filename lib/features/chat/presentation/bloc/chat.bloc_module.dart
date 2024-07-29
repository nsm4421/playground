import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio/features/chat/presentation/bloc/open_chat/chat_room/open_chat_room.bloc.dart';
import 'package:portfolio/features/chat/presentation/bloc/private_chat/display/display_private_chat.bloc.dart';
import 'package:portfolio/features/chat/presentation/bloc/private_chat/chat_room/private_chat_room.bloc.dart';
import 'package:portfolio/features/chat/presentation/bloc/open_chat/display/display_open_chat.cubit.dart';

import '../../../main/core/constant/status.dart';
import '../../domain/usecase/chat.usecase_module.dart';
import 'open_chat/create/create_open_chat.cubit.dart';

part "chat.state.dart";

part "chat.event.dart";

@lazySingleton
class ChatBlocModule {
  final ChatUseCase _useCase;

  ChatBlocModule(this._useCase);

  @injectable
  OpenChatRoomBloc openChatRoom(String chatId) =>
      OpenChatRoomBloc(_useCase, chatId: chatId);

  @injectable
  PrivateChatRoomBloc privateChatRoom(String chatId) =>
      PrivateChatRoomBloc(_useCase, chatId: chatId);

  @lazySingleton
  CreateOpenChatCubit get createOpenChat => CreateOpenChatCubit(_useCase);

  @lazySingleton
  DisplayPrivateChatBloc get displayPrivateChat =>
      DisplayPrivateChatBloc(_useCase);

  @lazySingleton
  DisplayOpenChatCubit get displayOpenChat => DisplayOpenChatCubit(_useCase);
}
