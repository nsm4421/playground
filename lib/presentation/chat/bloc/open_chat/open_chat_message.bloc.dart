import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/entity/chat/open_chat/message/open_chat_message.entity.dart';
import '../../../../domain/usecase/chat/open_chat/open_chat_messsage.usecase.dart';

part 'open_chat_message.event.dart';

part 'open_chat_message.state.dart';

class OpenChatMessageBloc
    extends Bloc<OpenChatMessageEvent, OpenChatMessageState> {
  final String _chatId;
  final ChatMessageUseCase _useCase;

  late Stream<List<OpenChatMessageEntity>> _stream;
  List<OpenChatMessageEntity> _messages = [];

  OpenChatMessageBloc(
      {@factoryParam required String chatId,
      required ChatMessageUseCase useCase})
      : _chatId = chatId,
        _useCase = useCase,
        super(InitialChatMessageState()) {
    on<InitChatMessageEvent>(_onInit);
    on<SendChatMessageEvent>(_onSendMessage);
    on<DeleteChatMessageEvent>(_onDeleteMessage);
    on<NewChatMessageEvent>(_onData);
  }

  Stream<List<OpenChatMessageEntity>> get messageStream => _stream;

  List<OpenChatMessageEntity> get messages => _messages;

  Future<void> _onInit(
      InitChatMessageEvent event, Emitter<OpenChatMessageState> emit) async {
    try {
      emit(InitialChatMessageState());
      _messages = await _useCase.getLocalChatMessages(_chatId);
      _stream = _useCase.getChatMessageStream(_chatId);
      emit(ChatMessageSuccessState());
    } catch (err) {
      debugPrint(err.toString());
      emit(ChatMessageFailureState('Error...'));
    }
  }

  Future<void> _onSendMessage(
      SendChatMessageEvent event, Emitter<OpenChatMessageState> emit) async {
    try {
      emit(ChatMessageLoadingState());
      final res = await _useCase.sendChatMessage(
          chatId: event.chatId,
          content: event.content,
          currentUser: event.currentUser);
      res.fold((l) => emit(ChatMessageFailureState(l.message ?? '메세지 전송 실패')),
          (r) => emit(ChatMessageSuccessState()));
    } catch (err) {
      debugPrint(err.toString());
      emit(ChatMessageFailureState('메세지 전송 실패'));
    }
  }

  Future<void> _onDeleteMessage(
      DeleteChatMessageEvent event, Emitter<OpenChatMessageState> emit) async {
    try {
      emit(ChatMessageLoadingState());
      final res = await _useCase.deleteChatMessage(event.messageId);
      res.fold(
          (l) => emit(
              ChatMessageFailureState(l.message ?? l.message ?? '메세지 삭제 실패')),
          (r) => emit(ChatMessageSuccessState()));
    } catch (err) {
      debugPrint(err.toString());
      emit(ChatMessageFailureState('메세지 삭제 실패'));
    }
  }

  Future<void> _onData(
      NewChatMessageEvent event, Emitter<OpenChatMessageState> emit) async {
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
