import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/data/entity/chat/open_chat/open_chat.entity.dart';
import 'package:my_app/domain/usecase/module/chat/open_chat.usecase.dart';
import 'package:my_app/presentation/bloc/chat/open_chat/create/create_open_chat.state.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/constant/status.dart';

class CreateOpenChatCubit extends Cubit<CreateOpenChatState> {
  final OpenChatUseCase _useCase;

  CreateOpenChatCubit(this._useCase) : super(const CreateOpenChatState());

  setTitle(String title) => emit(state.copyWith(title: title));

  upload() async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.createChat(OpenChatEntity(
          id: const Uuid().v4(),
          title: state.title,
          createdAt: DateTime.now()));
      emit(state.copyWith(status: Status.success));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: Status.error));
    }
  }
}
