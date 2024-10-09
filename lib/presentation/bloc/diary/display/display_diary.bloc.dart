import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel/core/util/util.dart';
import 'package:travel/domain/entity/diary/diary.dart';

import '../../../../core/constant/constant.dart';
import '../../../../domain/usecase/diary/usecase.dart';

part 'display_diary.state.dart';

part 'display_diary.event.dart';

class DisplayDiaryBloc extends Bloc<DisplayDiaryEvent, DisplayDiaryState> {
  final DiaryUseCase _useCase;

  DisplayDiaryBloc(this._useCase) : super(DisplayDiaryState()) {
    on<FetchDiariesEvent>(_onFetch);
  }

  Future<void> _onFetch(
      FetchDiariesEvent event, Emitter<DisplayDiaryState> emit) async {
    try {
      emit(state.copyWith(
        status: Status.loading,
        isFetching: true,
        diaries: event.refresh ? [] : state.diaries,
        isEnd: event.refresh ? false : state.isEnd,
      ));
      await _useCase.fetch(state.beforeAt, take: event.take).then((res) =>
          res.fold((l) {
            emit(state.copyWith(status: Status.error, errorMessage: l.message));
          }, (r) {
            emit(state.copyWith(
                status: Status.success,
                isEnd: event.take > r.length,
                diaries: [...state.diaries, ...r]));
          }));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error,
          errorMessage: 'error occurs on fetching diaries'));
      customUtil.logger.e(error);
    } finally {
      emit(state.copyWith(isFetching: false));
    }
  }
}
