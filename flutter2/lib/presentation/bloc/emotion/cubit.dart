import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/core/abstract/abstract.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/domain/usecase/emotion/usecase.dart';

part 'state.dart';

class EmotionCubit<RefEntity extends BaseEntity>
    extends Cubit<EmotionState<RefEntity>> with CustomLogger {
  final EmotionUseCase useCase;
  final RefEntity _ref;

  EmotionCubit(@factoryParam this._ref, {required this.useCase})
      : super(EmotionState<RefEntity>(_ref));

  void initState({Status? status, String? message, Emotions? emotion}) {
    emit(state.copyWith(
      status: status ?? state.status,
      message: message ?? state.message,
      emotion: emotion ?? state.emotion,
    ));
  }

  Future<void> handleSendLike(String referenceId,
      {Emotions emotion = Emotions.like}) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await useCase.like
          .call(referenceId: referenceId, referenceTable: _ref.table.name)
          .then((res) => res.fold(
              (l) => emit(
                  state.copyWith(status: Status.error, message: l.message)),
              (r) => emit(state.copyWith(
                  status: Status.success, message: '', emotion: emotion))));
    } catch (error) {
      emit(state.copyWith(status: Status.error, message: 'like request fails'));
      logger.e(error);
    }
  }

  Future<void> handleCancelLike(String referenceId) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await useCase.cancel
          .call(referenceId: referenceId, referenceTable: _ref.table.name)
          .then((res) => res.fold(
              (l) => emit(
                  state.copyWith(status: Status.error, message: l.message)),
              (r) => emit(state.copyWith(
                  status: Status.success,
                  message: '',
                  emotion: Emotions.none))));
    } catch (error) {
      emit(state.copyWith(
          status: Status.error, message: 'cancel like request fails'));
      logger.e(error);
    }
  }
}
