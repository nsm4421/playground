import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/util/bloc/display_bloc.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/domain/entity/reels/reels.dart';
import 'package:travel/domain/usecase/reels/usecase.dart';

class DisplayReelsBloc extends CustomDisplayBloc<ReelsEntity>
    with CustomLogger {
  final ReelsUseCase _useCase;

  DisplayReelsBloc(this._useCase);

  @override
  Future<void> onFetch(FetchEvent<ReelsEntity> event,
      Emitter<CustomDisplayState<ReelsEntity>> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.fetch
          .call(
              beforeAt: event.refresh ? now : state.beforeAt, take: event.take)
          .then((res) => res.fold(
              (l) => emit(state.copyWith(
                  status: Status.error, errorMessage: l.message)),
              (r) => emit(state.copyWith(
                  status: Status.success,
                  errorMessage: '',
                  data: event.refresh ? r : [...state.data, ...r],
                  isEnd: r.length < event.take))));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(
          status: Status.error, errorMessage: 'fail to fetch feed'));
    }
  }
}
