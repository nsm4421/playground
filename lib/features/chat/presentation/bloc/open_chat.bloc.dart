import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio/features/chat/domain/entity/chat_message.entity.dart';
import 'package:portfolio/features/chat/domain/entity/open_chat.entity.dart';
import 'package:portfolio/features/chat/domain/usecase/chat.usecase_module.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main/core/constant/status.dart';

part "open_chat.state.dart";

part "open_chat.event.dart";

@injectable
class OpenChatBloc extends Bloc<OpenChatEvent, OpenChatState> {
  final ChatUseCase _useCase;

  OpenChatBloc(this._useCase) : super(OpenChatState()) {
    on<InitOpenChatEvent>(_onInit);
    on<CreateOpenChatEvent>(_onCreate);
    on<SendOpenChatMessageEvent>(_onSend);
  }

  Stream<List<OpenChatEntity>> get openChatStream =>
      _useCase.getOpenChatStream();

  RealtimeChannel getOpenChatMessageChannel(
          {required String chatId,
          required void Function(ChatMessageEntity entity) onInsert}) =>
      _useCase.openChatMessageChannel(chatId: chatId, onInsert: onInsert);

  // 상태 초기화
  Future<void> _onInit(
      InitOpenChatEvent event, Emitter<OpenChatState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      if (event is InitDisplayOpenChatEvent) {
        emit(DisplayOpenChatState().copyWith(
            status: event.status, message: event.message ?? state.message));
      } else if (event is InitCreateOpenChatEvent) {
        emit(CreateOpenChatState().copyWith(
            status: event.status, message: event.message ?? state.message));
      } else if (event is InitOpenChatRoomEvent) {
        emit(OpenChatRoomState().copyWith(
            status: event.status, message: event.message ?? state.message));
      }
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          status: Status.error, message: event.message ?? state.message));
    }
  }

  // 오픈 채팅방 만들기
  Future<void> _onCreate(
      CreateOpenChatEvent event, Emitter<OpenChatState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final res = await _useCase.createOpenChat
          .call(title: event.title, hashtags: event.hashtags);
      if (res.ok) {
        emit(state.copyWith(status: Status.success));
      } else {
        emit(state.copyWith(status: Status.error, message: res.message));
      }
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  // 오픈 채팅 메시지 보내기
  Future<void> _onSend(
      SendOpenChatMessageEvent event, Emitter<OpenChatState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final res = await _useCase.sendOpenChatMessage
          .call(chatId: event.chatId, content: event.content);
      if (res.ok) {
        emit(state.copyWith(status: Status.success));
      } else {
        emit(state.copyWith(status: Status.error, message: res.message));
      }
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }
}
