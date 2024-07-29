import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../main/core/constant/status.dart';
import '../../../../domain/usecase/chat.usecase_module.dart';
import '../../chat.bloc_module.dart';

part "create_open_chat.state.dart";

class CreateOpenChatCubit extends Cubit<CreateOpenChatState> {
  CreateOpenChatCubit(this._useCase) : super(CreateOpenChatState());

  final ChatUseCase _useCase;

  Future<void> initStatus({Status status = Status.initial}) async {
    emit(state.copyWith(status: status));
  }

  Future<void> create(
      {required String title, required List<String> hashtags}) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final res =
          await _useCase.createOpenChat.call(title: title, hashtags: hashtags);
      if (res.ok) {
        emit(state.copyWith(status: Status.success));
      } else {
        emit(state.copyWith(
            status: Status.error,
            message: res.message ?? 'create chat room fails'));
      }
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }
}
