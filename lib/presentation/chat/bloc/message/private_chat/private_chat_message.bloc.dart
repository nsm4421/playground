import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/entity/chat/private_chat/message/private_chat_message.entity.dart';
import '../../../../../domain/usecase/chat/message/private_chat_message.usecase.dart';

part 'private_chat_message.event.dart';

part 'private_chat_message.state.dart';

class PrivateChatMessageBloc
    extends Bloc<PrivateChatMessageEvent, PrivateChatMessageState> {
  final String _chatId;
  final PrivateChatMessageUseCase _useCase;

  late Stream<List<PrivateChatMessageEntity>> _stream;
  List<PrivateChatMessageEntity> _messages = [];

  PrivateChatMessageBloc(
      {@factoryParam required String chatId,
      required PrivateChatMessageUseCase useCase})
      : _chatId = chatId,
        _useCase = useCase,
        super(InitialPrivateChatMessageState()) {
    on<InitPrivateChatMessageEvent>(_onInit);
    on<SendPrivateChatMessageEvent>(_onSendMessage);
    on<DeletePrivateChatMessageEvent>(_onDeleteMessage);
    on<NewPrivateChatMessageEvent>(_onData);
  }

  Stream<List<PrivateChatMessageEntity>> get messageStream => _stream;

  List<PrivateChatMessageEntity> get messages => _messages;

  Future<void> _onInit(InitPrivateChatMessageEvent event,
      Emitter<PrivateChatMessageState> emit) async {
    try {
      emit(InitialPrivateChatMessageState());
      _messages = await _useCase.getLocalChatMessages(_chatId);
      _stream = _useCase.getChatMessageStream(_chatId);
      emit(PrivateChatMessageSuccessState());
    } catch (err) {
      debugPrint(err.toString());
      emit(PrivateChatMessageFailureState('Error...'));
    }
  }

  Future<void> _onSendMessage(SendPrivateChatMessageEvent event,
      Emitter<PrivateChatMessageState> emit) async {
    try {
      emit(PrivateChatMessageLoadingState());
      final res = await _useCase.sendChatMessage(
          chatId: event.chatId,
          content: event.content,
          currentUser: event.currentUser,
          receiver: event.receiver);
      res.fold(
          (l) => emit(PrivateChatMessageFailureState(l.message ?? '메세지 전송 실패')),
          (r) => emit(PrivateChatMessageSuccessState()));
    } catch (err) {
      debugPrint(err.toString());
      emit(PrivateChatMessageFailureState('메세지 전송 실패'));
    }
  }

  Future<void> _onDeleteMessage(DeletePrivateChatMessageEvent event,
      Emitter<PrivateChatMessageState> emit) async {
    try {
      emit(PrivateChatMessageLoadingState());
      final res = await _useCase.deleteChatMessage(event.messageId);
      res.fold(
          (l) => emit(PrivateChatMessageFailureState(
              l.message ?? l.message ?? '메세지 삭제 실패')),
          (r) => emit(PrivateChatMessageSuccessState()));
    } catch (err) {
      debugPrint(err.toString());
      emit(PrivateChatMessageFailureState('메세지 삭제 실패'));
    }
  }

  Future<void> _onData(NewPrivateChatMessageEvent event,
      Emitter<PrivateChatMessageState> emit) async {
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
