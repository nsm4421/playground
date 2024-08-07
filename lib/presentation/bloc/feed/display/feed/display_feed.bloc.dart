import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/constant/status.dart';
import 'package:portfolio/domain/entity/feed/feed.entity.dart';
import 'package:portfolio/domain/usecase/emotion/emotion.usecase_module.dart';

import '../../../../../domain/usecase/feed/feed.usecase_module.dart';
import '../../feed.bloc_module.dart';

part "display_feed.state.dart";

part "display_feed.event.dart";

class DisplayFeedBloc extends Bloc<DisplayFeedEvent, DisplayFeedState> {
  final FeedUseCase _feedUseCase;
  final EmotionUseCase _emotionUseCase;

  DisplayFeedBloc(
      {required FeedUseCase feedUseCase,
      required EmotionUseCase emotionUseCase})
      : _feedUseCase = feedUseCase,
        _emotionUseCase = emotionUseCase,
        super(DisplayFeedState(beforeAt: DateTime.now().toUtc())) {
    on<FetchFeedEvent>(_onFetch);
    on<LikeFeedEvent>(_onLike);
    on<CancelLikeFeedEvent>(_onCancelLike);
    on<DeleteFeedEvent>(_onDelete);
    on<FeedCreatedEvent>(_onCreated);
  }

  Future<void> _onFetch(
      FetchFeedEvent event, Emitter<DisplayFeedState> emit) async {
    try {
      emit(state.copyWith(isFetching: true));
      final res = await _feedUseCase.fetchFeeds(
          beforeAt: state.beforeAt, take: event.take);
      if (res.ok) {
        final data = res.data ?? [];
        final beforeAt = data.isNotEmpty
            ? data
                .reduce((r, l) => r.createdAt!.isBefore(l.createdAt!) ? r : l)
                .createdAt
            : state.beforeAt;
        emit(state.copyWith(
            status: Status.success,
            isFetching: false,
            isEnd: data.length < event.take,
            data: [...state.data, ...data],
            beforeAt: beforeAt));
      } else {
        emit(state.copyWith(
            status: Status.error, isFetching: false, message: res.message));
      }
    } catch (error) {
      log('_onFetch : ${error.toString()}');
      emit(state.copyWith(
          status: Status.error,
          isFetching: false,
          message: 'fetch feeds fail'));
    }
  }

  Future<void> _onLike(
      LikeFeedEvent event, Emitter<DisplayFeedState> emit) async {
    try {
      emit(state.copyWith(emotionStatus: Status.loading));
      final res = await _emotionUseCase.likeFeed(event.feedId);
      if (res.ok && res.data != null) {
        emit(state.copyWith(
            emotionStatus: Status.success,
            data: state.data
                .map((feed) => feed.id == event.feedId
                    ? feed.copyWith(emotion: res.data)
                    : feed)
                .toList()));
      } else {
        emit(state.copyWith(emotionStatus: Status.error, message: res.message));
      }
    } catch (error) {
      log('_onLike : ${error.toString()}');
      emit(state.copyWith(
          emotionStatus: Status.error, message: 'like feed fails'));
    }
  }

  Future<void> _onCancelLike(
      CancelLikeFeedEvent event, Emitter<DisplayFeedState> emit) async {
    try {
      emit(state.copyWith(emotionStatus: Status.loading));
      final res = await _emotionUseCase.deleteById(event.emotionId);
      if (res.ok) {
        emit(state.copyWith(
            emotionStatus: Status.success,
            data: state.data
                .map((feed) => feed.id == event.feedId
                    ? feed.copyWith(emotion: null)
                    : feed)
                .toList()));
      } else {
        emit(state.copyWith(emotionStatus: Status.error, message: res.message));
      }
    } catch (error) {
      log('_onCancelLike : ${error.toString()}');
      emit(state.copyWith(
          emotionStatus: Status.error, message: 'cancel like fails'));
    }
  }

  Future<void> _onDelete(
      DeleteFeedEvent event, Emitter<DisplayFeedState> emit) async {
    try {
      emit(state.copyWith(emotionStatus: Status.loading));
      final res = await _feedUseCase.deleteFeed(event.feedId);
      if (res.ok) {
        emit(state.copyWith(
            emotionStatus: Status.success,
            data:
                state.data.where((feed) => feed.id != event.feedId).toList()));
      } else {
        emit(state.copyWith(emotionStatus: Status.error, message: res.message));
      }
    } catch (error) {
      log('_onDelete : ${error.toString()}');
      emit(state.copyWith(
          emotionStatus: Status.error, message: 'delete feed fails'));
    }
  }

  Future<void> _onCreated(
      FeedCreatedEvent event, Emitter<DisplayFeedState> emit) async {
    try {
      emit(state.copyWith(data: [event._feed, ...state.data]));
    } catch (error) {
      log('_onCreate : ${error.toString()}');
      emit(state.copyWith(
          emotionStatus: Status.error, message: 'add feed fails'));
    }
  }
}
