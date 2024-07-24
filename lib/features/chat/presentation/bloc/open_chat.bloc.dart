import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio/features/chat/domain/usecase/chat.usecase_module.dart';

import '../../../main/core/constant/status.dart';

part "open_chat.state.dart";

part "open_chat.event.dart";

@singleton
class OpenChatBloc extends Bloc<OpenChatEvent, OpenChatState> {
  final ChatUseCase _useCase;

  OpenChatBloc(this._useCase) : super(OpenChatState()) {
    on<CreateOpenChatEvent>(_onCreate);
  }

  Future<void> _onCreate(
      CreateOpenChatEvent event, Emitter<OpenChatState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final res = await _useCase.createOpenChat.call(
          title: event.title,
          hashtags: event.hashtags,
          createdBy: event.createdBy);
      if (res.ok) {
        emit(state.copyWith(status: Status.success));
      } else {
        emit(state.copyWith(status: Status.error, message: res.message));
      }
    } catch (error) {
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }
}
