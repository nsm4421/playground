import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/entity/chat/chat_message/open_chat_message.entity.dart';
import 'package:my_app/data/entity/chat/open_chat/open_chat.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/exception/custom_exception.dart';
import '../../../../../domain/usecase/module/chat/open_chat.usecase.dart';
import '../../../../../domain/usecase/module/chat/open_chat_message.usecase.dart';

part 'display_open_chat_message.event.dart';

part 'display_open_chat_message.state.dart';

class DisplayOpenChatMessageBloc
    extends Bloc<DisplayOpenChatMessageEvent, DisplayOpenChatMessageState> {
  final OpenChatEntity _chat;
  final OpenChatUseCase _openChatUseCase;
  final OpenChatMessageUseCase _openChatMessageUseCase;

  DisplayOpenChatMessageBloc(@factoryParam OpenChatEntity chat,
      {required OpenChatUseCase openChatUseCase,
      required OpenChatMessageUseCase openChatMessageUseCase})
      : _chat = chat,
        _openChatUseCase = openChatUseCase,
        _openChatMessageUseCase = openChatMessageUseCase,
        super(InitialOpenChatMessageState()) {
    on<InitOpenChatMessageEvent>(_onInit);
  }

  RealtimeChannel getMessageChannel(
          void Function(OpenChatMessageEntity entity) onInsert) =>
      _openChatMessageUseCase.getMessageChannel(
          chatId: _chat.id!, onInsert: onInsert);

  Future<void> _onInit(InitOpenChatMessageEvent event,
      Emitter<DisplayOpenChatMessageState> emit) async {
    try {
      emit(InitialOpenChatMessageState());
    } catch (error) {
      log(error.toString());
      emit(OpenChatMessageFailureState(
          (error is CustomException) ? error.message : '알 수 없는 오류 발생'));
    }
  }
}
