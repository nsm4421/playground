import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

import 'package:flutter/foundation.dart';
import 'package:hot_place/domain/usecase/chat/room/private_chat.usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/entity/chat/private_chat/message/private_chat_message.entity.dart';
import '../../../../../domain/usecase/chat/message/private_chat_message.usecase.dart';

part 'private_chat_message.event.dart';

part 'private_chat_message.state.dart';

class PrivateChatMessageBloc
    extends Bloc<PrivateChatMessageEvent, PrivateChatMessageState> {
  final String _chatId;
  final PrivateChatUseCase _chatUseCase;
  final PrivateChatMessageUseCase _messageUseCase;

  late Stream<List<PrivateChatMessageEntity>> _stream;
  List<PrivateChatMessageEntity> _messages = [];

  PrivateChatMessageBloc({
    @factoryParam required String chatId,
    required PrivateChatUseCase chatUseCase,
    required PrivateChatMessageUseCase messageUseCase,
  })  : _chatId = chatId,
        _chatUseCase = chatUseCase,
        _messageUseCase = messageUseCase,
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
      _messages = await _messageUseCase.getLocalChatMessages(_chatId);
      _stream = _messageUseCase.getChatMessageStream(_chatId);
      emit(PrivateChatMessageSuccessState());
    } catch (err) {
      debugPrint(err.toString());
      emit(PrivateChatMessageFailureState('Error...'));
    }
  }

  Future<void> _onSendMessage(SendPrivateChatMessageEvent event,
      Emitter<PrivateChatMessageState> emit) async {
    final createdAt = DateTime.now();
    // 메세지 보내기
    try {
      emit(PrivateChatMessageLoadingState());
      final message = await _messageUseCase
          .sendChatMessage(
              chatId: event.chatId,
              content: event.content,
              currentUser: event.currentUser,
              receiver: event.receiver,
              createdAt: createdAt)
          .then((res) => res.fold(
              (l) => emit(
                  PrivateChatMessageFailureState(l.message ?? '메세지 전송 실패')),
              (r) => emit(PrivateChatMessageSuccessState())));
    } catch (err) {
      debugPrint(err.toString());
      emit(PrivateChatMessageFailureState('메세지 전송 실패'));
    }
    // 채팅방 마지막 메세지 업데이트
    try {
      await _chatUseCase.updateLastMessage.call(
        currentUser: event.currentUser,
        receiver: event.receiver,
        lastMessage: event.content,
        lastTalkAt: createdAt,
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> _onDeleteMessage(DeletePrivateChatMessageEvent event,
      Emitter<PrivateChatMessageState> emit) async {
    // 메세지 삭제
    try {
      emit(PrivateChatMessageLoadingState());
      await _messageUseCase.deleteChatMessage(event.messageId).then((res) =>
          res.fold(
              (l) => emit(PrivateChatMessageFailureState(
                  l.message ?? l.message ?? '메세지 삭제 실패')),
              (r) => emit(PrivateChatMessageSuccessState())));
    } catch (err) {
      debugPrint(err.toString());
      emit(PrivateChatMessageFailureState('메세지 삭제 실패'));
    }
    // 채팅방 마지막 메세지 수정
    try {
      await _chatUseCase.updateLastMessage.call(
          currentUser: event.currentUser,
          receiver: event.receiver,
          lastMessage: "삭제된 메세지 입니다");
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> _onData(NewPrivateChatMessageEvent event,
      Emitter<PrivateChatMessageState> emit) async {
    try {
      final idOfSavedMessages = _messages.map((e) => e.id);
      final messagesToSave = event.messages
          .where((element) => !idOfSavedMessages.contains(element.id));
      await _messageUseCase.saveMessagesInLocal(messagesToSave);
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
