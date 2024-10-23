import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/display_bloc.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/util/util.dart';
import '../../../../domain/entity/diary/diary.dart';
import '../../../../domain/usecase/diary/usecase.dart';

class DisplayDiaryBloc extends CustomDisplayBloc<DiaryEntity> {
  final DiaryUseCase _useCase;

  DisplayDiaryBloc(this._useCase);

  @override
  Future<void> onFetch(FetchEvent<DiaryEntity> event,
      Emitter<CustomDisplayState<DiaryEntity>> emit) async {
    try {
      emit(state.copyWith(
        status: event.refresh ? Status.loading : state.status,
        isFetching: true,
        data: event.refresh ? [] : state.data,
        isEnd: event.refresh ? false : state.isEnd,
      ));
      await _useCase
          .fetch(state.beforeAt, take: event.take)
          .then((res) => emit(state.from(res, take: event.take)));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: 'error occurs on fetching data'));
      customUtil.logger.e(error);
    } finally {
      emit(state.copyWith(isFetching: false));
    }
  }
}
