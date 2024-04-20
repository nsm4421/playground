import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/entity/chat/private_chat/message/private_chat_message.entity.dart';
import '../../../../../data/entity/user/user.entity.dart';

part "private_chat_message.event.dart";

part 'private_chat_message.state.dart';

class PrivateChatBloc
    extends Bloc<PrivateChatMessageEvent, PrivateChatMessageState> {
  // final String _chatId;
  // final PrivateChatMessageUseCase _useCase;
  //
  // late Stream<List<PrivateChatMessageEntity>> _stream;
  // List<PrivateChatMessageEntity> _messages = [];
  //
  // PrivateChatBloc(
  //     {@factoryParam required String chatId,
  //     required PrivateChatMessageUseCase useCase})
  //     : _chatId = chatId,
  //       _useCase = useCase,
  //       super(InitialChatMessageState()) {
  //   on<InitChatMessageEvent>(_onInit);
  // }
  //
  // Future<void> _onInit(
  //     InitChatMessageEvent event, Emitter<PrivateChatMessageState> emit) async {
  //   try {
  //     emit(InitialChatMessageState());
  //     _messages = await _useCase.getLocalChatMessages(_chatId);
  //     _stream = _useCase.getChatMessageStream(_chatId);
  //     emit(ChatMessageSuccessState());
  //   } catch (err) {
  //     debugPrint(err.toString());
  //     emit(ChatMessageFailureState('Error...'));
  //   }
  // }
}
