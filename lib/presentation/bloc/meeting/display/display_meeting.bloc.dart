import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/core/bloc/display_bloc.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/util/util.dart';
import '../../../../domain/entity/meeting/meeting.dart';
import '../../../../domain/usecase/meeting/usecase.dart';

class DisplayMeetingBloc extends CustomDisplayBloc<MeetingEntity> {
  final MeetingUseCase _useCase;

  DisplayMeetingBloc(this._useCase);

  @override
  Future<void> onFetch(FetchEvent<MeetingEntity> event,
      Emitter<CustomDisplayState<MeetingEntity>> emit) async {
    try {
      emit(state.copyWith(
        status: state.data.isEmpty ? Status.loading : state.status,
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
