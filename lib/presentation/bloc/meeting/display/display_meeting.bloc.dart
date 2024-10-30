import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/display_bloc.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/util/util.dart';
import '../../../../domain/entity/meeting/meeting.dart';
import '../../../../domain/usecase/meeting/usecase.dart';

part 'display_meeting.event.dart';

class DisplayMeetingBloc extends CustomDisplayBloc<MeetingEntity> {
  final MeetingUseCase _useCase;
  late MeetingSearchOption _option;

  MeetingSearchOption get option => _option;

  DisplayMeetingBloc(this._useCase) {
    _option = MeetingSearchOption();
    on<SearchMeetingEvent>(_onSearch);
    on<MeetingFilterOffEvent>(_onFilterOff);
  }

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

  Future<void> _onSearch(SearchMeetingEvent event,
      Emitter<CustomDisplayState<MeetingEntity>> emit) async {
    try {
      emit(state.copyWith(
        status: Status.loading,
        isFetching: true,
        data: [],
        isEnd: false,
      ));
      await _useCase
          .search(state.beforeAt,
              take: event.take,
              // 검색옵션
              sex: event.option.sex == AccompanySexType.all
                  ? null
                  : event.option.sex,
              theme: event.option.theme == TravelThemeType.all
                  ? null
                  : event.option.theme,
              hashtag: event.option.hashtag.trim().isEmpty
                  ? null
                  : event.option.hashtag)
          .then((res) {
        _option = event.option;
        emit(state.from(res, take: event.take));
      });
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: 'error occurs on search data'));
      customUtil.logger.e(error);
    } finally {
      emit(state.copyWith(isFetching: false));
    }
  }

  Future<void> _onFilterOff(MeetingFilterOffEvent event,
      Emitter<CustomDisplayState<MeetingEntity>> emit) async {
    try {
      _option = MeetingSearchOption();
      emit(state.copyWith(
        status: Status.loading,
        isFetching: true,
        data: [],
        isEnd: false,
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
