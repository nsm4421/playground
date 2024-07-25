import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio/features/chat/domain/entity/open_chat.entity.dart';
import 'package:portfolio/features/chat/domain/usecase/chat.usecase_module.dart';

import '../../../main/core/constant/status.dart';

part "open_chat.state.dart";

part "open_chat.event.dart";

@injectable
class OpenChatBloc extends Bloc<OpenChatEvent, OpenChatState> {
  final ChatUseCase _useCase;

  OpenChatBloc(this._useCase) : super(OpenChatState()) {
    on<InitOpenChatEvent>(_onInit);
    on<CreateOpenChatEvent>(_onCreate);
  }

  Stream<List<OpenChatEntity>> get openChatStream =>
      _useCase.getOpenChatStream();

  Future<void> _onInit(
      InitOpenChatEvent event, Emitter<OpenChatState> emit) async {
    try {
      emit(state.copyWith(
          status: event.status, message: event.message ?? state.message));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          status: Status.error, message: event.message ?? state.message));
    }
  }

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
}
