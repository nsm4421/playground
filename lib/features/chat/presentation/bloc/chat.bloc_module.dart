import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio/features/chat/presentation/bloc/chat_room/open_chat_room.bloc.dart';
import 'package:portfolio/features/chat/presentation/bloc/display/display_open_chat.cubit.dart';

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

  @lazySingleton
  CreateOpenChatCubit get createOpenChat => CreateOpenChatCubit(_useCase);

  @lazySingleton
  DisplayOpenChatCubit get displayOpenChat => DisplayOpenChatCubit(_useCase);
}
