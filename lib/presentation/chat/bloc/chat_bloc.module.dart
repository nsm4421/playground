import 'package:hot_place/domain/usecase/chat/message/chat_messsage.usecase.dart';
import 'package:hot_place/presentation/chat/bloc/message/chat_message.bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/di/dependency_injection.dart';

@lazySingleton
class ChatBlocModule {
  @injectable
  ChatMessageBloc chatMessageBloc(@factoryParam String chatId) =>
      ChatMessageBloc(chatId: chatId, useCase: getIt<ChatMessageUseCase>());
}
