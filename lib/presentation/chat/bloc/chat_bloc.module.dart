import 'package:hot_place/domain/usecase/chat/message/open_chat_messsage.usecase.dart';
import 'package:hot_place/domain/usecase/chat/message/private_chat_message.usecase.dart';
import 'package:hot_place/presentation/chat/bloc/message/open_chat/open_chat_message.bloc.dart';
import 'package:hot_place/presentation/chat/bloc/message/private_chat/private_chat_message.bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/di/dependency_injection.dart';

@lazySingleton
class ChatBlocModule {
  @injectable
  OpenChatMessageBloc openChatMessageBloc(@factoryParam String chatId) =>
      OpenChatMessageBloc(
          chatId: chatId, useCase: getIt<OpenChatMessageUseCase>());

  @injectable
  PrivateChatMessageBloc privateChatMessageBloc(@factoryParam String chatId) =>
      PrivateChatMessageBloc(
          chatId: chatId, useCase: getIt<PrivateChatMessageUseCase>());
}
