import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/data/entity/chat/open_chat/open_chat.entity.dart';
import 'package:my_app/domain/usecase/module/chat/open_chat.usecase.dart';
import 'package:my_app/domain/usecase/module/chat/open_chat_message.usecase.dart';

import '../../../../../core/exception/custom_exception.dart';

part 'display_open_chat.state.dart';

part 'display_open_chat.event.dart';

class DisplayOpenChatBloc extends Bloc<DisplayOpenChatEvent, DisplayOpenChatState> {
  final OpenChatUseCase _openChatUseCase;
  final OpenChatMessageUseCase _openChatMessageUseCase;

  DisplayOpenChatBloc(
      {required OpenChatUseCase openChatUseCase,
      required OpenChatMessageUseCase openChatMessageUseCase})
      : _openChatUseCase = openChatUseCase,
        _openChatMessageUseCase = openChatMessageUseCase,
        super(InitialDisplayOpenChatState()) {
    on<InitDisplayOpenChatEvent>(_onInit);
    on<DeleteOpenChatEvent>(_onDeleteChat);
  }

  Stream<List<OpenChatEntity>> get chatStream => _openChatUseCase.chatStream();

  Future<void> _onInit(
      InitDisplayOpenChatEvent event, Emitter<DisplayOpenChatState> emit) async {
    try {
      emit(InitialDisplayOpenChatState());
    } catch (error) {
      log(error.toString());
      emit(DisplayOpenChatFailureState(
          (error is CustomException) ? error.message : '알 수 없는 오류 발생'));
    }
  }

  Future<void> _onDeleteChat(
      DeleteOpenChatEvent event, Emitter<DisplayOpenChatState> emit) async {
    try {
      emit(DisplayOpenChatLoadingState());
      await _openChatUseCase.delete(event.chatId).then((res) => res.fold(
          (l) => throw l.toCustomException(message: '채팅방 삭제 실패'),
          (r) => emit(DisplayOpenChatSuccessState())));
    } catch (error) {
      log(error.toString());
      emit(DisplayOpenChatFailureState(
          (error is CustomException) ? error.message : '알 수 없는 오류 발생'));
    }
  }
}
