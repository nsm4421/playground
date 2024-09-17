import 'dart:developer';

import 'package:flutter_app/like/domain/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/shared.export.dart';
import '../../../domain/domain.export.dart';

part 'display_feed.state.dart';

part 'dispaly_feed.event.dart';

@lazySingleton
class DisplayFeedBloc extends Bloc<DisplayFeedEvent, DisplayFeedState> {
  final FeedUseCase _feedUseCase;
  final LikeUseCase _likeUseCase;

  DisplayFeedBloc(
      {required FeedUseCase feedUseCase, required LikeUseCase likeUseCase})
      : _feedUseCase = feedUseCase,
        _likeUseCase = likeUseCase,
        super(DisplayFeedState()) {
    on<FetchFeedEvent>(_onFetch);
    on<RefreshEvent>(_onRefresh);
    on<LikeOnFeedEvent>(_onLike);
    on<CancelLikeOnFeedEvent>(_onCancelLike);
  }

  Future<void> _onFetch(
      FetchFeedEvent event, Emitter<DisplayFeedState> emit) async {
    try {
      log('[DisplayFeedBloc]_onFetch실행');
      if (state.isEnd) return;
      emit(state.copyWith(status: Status.loading));
      final res = await _feedUseCase.fetchFeeds(
          beforeAt: state.beforeAt, take: event.take);
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
          isEnd: fetched.length < event.take,
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

  Future<void> _onLike(
      LikeOnFeedEvent event, Emitter<DisplayFeedState> emit) async {
    try {
      log('[DisplayFeedBloc]_onLike 호출');
      emit(state.copyWith(status: Status.loading));
      await _likeUseCase.likeOnFeed(event.feedId);
      emit(state.copyWith(
          status: Status.success,
          data: state.data
              .map((item) => item.id == event.feedId
                  ? item.copyWith(isLike: true, likeCount: item.likeCount + 1)
                  : item)
              .toList()));
    } catch (error) {
      log('[DisplayFeedBloc]좋아요 요청 중 오류');
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onCancelLike(
      CancelLikeOnFeedEvent event, Emitter<DisplayFeedState> emit) async {
    try {
      log('[DisplayFeedBloc]_onCancelLike 호출');
      emit(state.copyWith(status: Status.loading));
      await _likeUseCase.cancelLikeOnFeed(event.feedId);
      emit(state.copyWith(
          status: Status.success,
          data: state.data
              .map((item) => item.id == event.feedId
                  ? item.copyWith(isLike: false, likeCount: item.likeCount - 1)
                  : item)
              .toList()));
    } catch (error) {
      log('[DisplayFeedBloc]좋아요 취소 중 오류');
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }
}
