import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/entity/chat/open_chat/message/open_chat_message.entity.dart';
import '../../../../../domain/usecase/chat/message/open_chat_messsage.usecase.dart';

part 'open_chat_message.event.dart';

part 'open_chat_message.state.dart';

class OpenChatMessageBloc
    extends Bloc<OpenChatMessageEvent, OpenChatMessageState> {
  final String _chatId;
  final OpenChatMessageUseCase _useCase;

  late Stream<List<OpenChatMessageEntity>> _stream;
  List<OpenChatMessageEntity> _messages = [];

  OpenChatMessageBloc(
      {@factoryParam required String chatId,
      required OpenChatMessageUseCase useCase})
      : _chatId = chatId,
        _useCase = useCase,
        super(InitialOpenChatMessageState()) {
    on<InitOpenChatMessageEvent>(_onInit);
    on<SendOpenChatMessageEvent>(_onSendMessage);
    on<DeleteOpenChatMessageEvent>(_onDeleteMessage);
    on<NewOpenChatMessageEvent>(_onData);
  }

  Stream<List<OpenChatMessageEntity>> get messageStream => _stream;

  List<OpenChatMessageEntity> get messages => _messages;

  Future<void> _onInit(
      InitOpenChatMessageEvent event, Emitter<OpenChatMessageState> emit) async {
    try {
      emit(InitialOpenChatMessageState());
      _messages = await _useCase.getLocalChatMessages(_chatId);
      _stream = _useCase.getChatMessageStream(_chatId);
      emit(OpenChatMessageSuccessState());
    } catch (err) {
      debugPrint(err.toString());
      emit(OpenChatMessageFailureState('Error...'));
    }
  }

  Future<void> _onSendMessage(
      SendOpenChatMessageEvent event, Emitter<OpenChatMessageState> emit) async {
    try {
      emit(OpenChatMessageLoadingState());
      final res = await _useCase.sendChatMessage(
          chatId: event.chatId,
          content: event.content,
          currentUser: event.currentUser);
      res.fold((l) => emit(OpenChatMessageFailureState(l.message ?? '메세지 전송 실패')),
          (r) => emit(OpenChatMessageSuccessState()));
    } catch (err) {
      debugPrint(err.toString());
      emit(OpenChatMessageFailureState('메세지 전송 실패'));
    }
  }

  Future<void> _onDeleteMessage(
      DeleteOpenChatMessageEvent event, Emitter<OpenChatMessageState> emit) async {
    try {
      emit(OpenChatMessageLoadingState());
      final res = await _useCase.deleteChatMessage(event.messageId);
      res.fold(
          (l) => emit(
              OpenChatMessageFailureState(l.message ?? l.message ?? '메세지 삭제 실패')),
          (r) => emit(OpenChatMessageSuccessState()));
    } catch (err) {
      debugPrint(err.toString());
      emit(OpenChatMessageFailureState('메세지 삭제 실패'));
    }
  }

  Future<void> _onData(
      NewOpenChatMessageEvent event, Emitter<OpenChatMessageState> emit) async {
    try {
      final idOfSavedMessages = _messages.map((e) => e.id);
      final messagesToSave = event.messages
          .where((element) => !idOfSavedMessages.contains(element.id));
      await _useCase.saveMessagesInLocal(messagesToSave);
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
