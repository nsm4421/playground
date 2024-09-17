import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/shared.export.dart';
import '../../../domain/domain.export.dart';

part 'display_feed.state.dart';

part 'dispaly_feed.event.dart';

@lazySingleton
class DisplayFeedBloc extends Bloc<DisplayFeedEvent, DisplayFeedState> {
  final FeedUseCase _useCase;

  DisplayFeedBloc(this._useCase) : super(DisplayFeedState()) {
    on<FetchFeedEvent>(_onFetch);
    on<RefreshEvent>(_onRefresh);
  }

  Future<void> _onFetch(
      FetchFeedEvent event, Emitter<DisplayFeedState> emit) async {
    try {
      log('[DisplayFeedBloc]_onFetch실행');
      if (state.isEnd) return;
      emit(state.copyWith(status: Status.loading));
      final res = await _useCase.fetchFeeds(
          beforeAt: state.beforeAt, limit: event.limit);
      if (!res.ok || res.data == null) {
        log(res.message ?? '[DisplayFeedBloc]피드 가져오는 중 오류');
        emit(state.copyWith(status: Status.error, errorMessage: res.message));
        return;
      }
      log('[DisplayFeedBloc]피드 가져오기 성공 beforeAt:${state.beforeAt} 개수:${res.data?.length ?? 0}');
      final fetched = res.data!;
      emit(state.copyWith(
          status: Status.success,
          data: [...state.data, ...fetched],
          isEnd: fetched.length < event.limit,
          beforeAt: fetched.isEmpty
              ? state.beforeAt
              : fetched
                  .map((item) => item.createdAt)
                  .map((text) => DateTime.tryParse(text!))
                  .reduce((l, r) => l!.isBefore(r!) ? l : r)));
    } catch (error) {
      log('[DisplayFeedBloc]피드 가져오는 중 오류 발생 ${error.toString()}');
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onRefresh(
      RefreshEvent event, Emitter<DisplayFeedState> emit) async {
    try {
      log('[DisplayFeedBloc]_onRefresh 호출');
      emit(DisplayFeedState());
    } catch (error) {
      log('[DisplayFeedBloc]새로고침 중 오류');
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }
}
