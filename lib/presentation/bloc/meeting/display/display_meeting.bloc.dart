import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/util/util.dart';
import '../../../../domain/entity/meeting/meeting.dart';
import '../../../../domain/usecase/meeting/usecase.dart';

part 'display_meeting.event.dart';

class DisplayMeetingBloc
    extends Bloc<DisplayMeetingEvent, CustomDisplayState<MeetingEntity>> {
  final MeetingUseCase _useCase;

  DisplayMeetingBloc(this._useCase)
      : super(CustomDisplayState<MeetingEntity>()) {
    on<FetchMeetingEvent>(_onFetch);
  }

  Future<void> _onFetch(FetchMeetingEvent event,
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
