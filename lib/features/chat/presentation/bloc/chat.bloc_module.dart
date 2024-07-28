import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio/features/chat/presentation/bloc/chat_room/open_chat/open_chat_room.bloc.dart';
import 'package:portfolio/features/chat/presentation/bloc/chat_room/private_chat/private_chat_room.bloc.dart';
import 'package:portfolio/features/chat/presentation/bloc/display/open_chat/display_open_chat.cubit.dart';
import 'package:portfolio/features/chat/presentation/bloc/display/private_chat/display_private_chat.cubit.dart';

import '../../../main/core/constant/status.dart';
import '../../domain/usecase/chat.usecase_module.dart';
import 'create/create_open_chat.cubit.dart';

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
  DisplayOpenChatCubit get displayOpenChat => DisplayOpenChatCubit(_useCase);

  @lazySingleton
  DisplayPrivateChatCubit get displayPrivateChat =>
      DisplayPrivateChatCubit(_useCase);
}
