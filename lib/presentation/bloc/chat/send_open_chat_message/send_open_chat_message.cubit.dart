import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/entity/chat/open_chat/open_chat.entity.dart';
import 'package:my_app/domain/usecase/module/chat/open_chat.usecase.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/constant/status.dart';
import '../../../../data/entity/chat/chat_message/open_chat_message.entity.dart';
import '../../../../domain/usecase/module/chat/open_chat_message.usecase.dart';
import 'send_open_chat_message.state.dart';

class SendOpenChatMessageCubit extends Cubit<SendOpenChatMessageState> {
  final OpenChatEntity _chat;

  final OpenChatUseCase _chatUseCase;
  final OpenChatMessageUseCase _messageUseCase;

  SendOpenChatMessageCubit(@factoryParam OpenChatEntity chat,
      {required OpenChatUseCase chatUseCase,
      required OpenChatMessageUseCase messageUseCase})
      : _chat = chat,
        _chatUseCase = chatUseCase,
        _messageUseCase = messageUseCase,
        super(const SendOpenChatMessageState()) {
    emit(state.copyWith(chatId: _chat.id!));
  }

  send(String content) async {
    try {
      emit(state.copyWith(status: Status.loading, content: content));
      await _messageUseCase.sendMessage(OpenChatMessageEntity(
          chatId: state.chatId,
          id: const Uuid().v4(),
          content: content,
          createdAt: DateTime.now()));
      emit(state.copyWith(status: Status.success, content: ''));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: Status.error));
    }
    try {
      await _chatUseCase.modifyChat(_chat.id!,
          lastTalkAt: DateTime.now(), lastMessage: content);
    } catch (error) {
      log(error.toString());
    }
  }
}
