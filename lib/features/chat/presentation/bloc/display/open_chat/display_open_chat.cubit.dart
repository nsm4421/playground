import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/features/chat/domain/entity/open_chat.entity.dart';

import '../../../../main/core/constant/status.dart';
import '../../../domain/usecase/chat.usecase_module.dart';
import '../chat.bloc_module.dart';

part "display_open_chat.state.dart";

class DisplayOpenChatCubit extends Cubit<DisplayOpenChatState> {
  DisplayOpenChatCubit(this._useCase) : super(DisplayOpenChatState());

  final ChatUseCase _useCase;

  Stream<List<OpenChatEntity>> get chatStream => _useCase.getOpenChatStream();

  Future<void> initStatus({Status status = Status.initial}) async {
    emit(state.copyWith(status: status));
  }
}
