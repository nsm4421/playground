import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio/presentation/bloc/feed/feed.bloc_module.dart';

import '../../../../../core/constant/status.dart';
import '../../../../../domain/entity/feed/feed_comment.entity.dart';
import '../../../../../domain/usecase/emotion/emotion.usecase_module.dart';
import '../../../../../domain/usecase/feed/feed.usecase_module.dart';

part "display_feed_comment.state.dart";

part "display_feed_comment.event.dart";

class DisplayFeedCommentBloc
    extends Bloc<DisplayFeedCommentEvent, DisplayFeedCommentState> {
  final String _feedId;
  final FeedUseCase _feedUseCase;
  final EmotionUseCase _emotionUseCase;

  String get feeId => _feedId;

  DisplayFeedCommentBloc(@factoryParam String feedId,
      {required FeedUseCase feedUseCase,
      required EmotionUseCase emotionUseCase})
      : _feedId = feedId,
        _feedUseCase = feedUseCase,
        _emotionUseCase = emotionUseCase,
        super(DisplayFeedCommentState(beforeAt: DateTime.now().toUtc())) {
    on<FetchFeedCommentEvent>(_onFetch);
    on<LikeFeedCommentEvent>(_onLike);
    on<CancelLikeFeedCommentEvent>(_onCancelLike);
  }

  Future<void> _onFetch(FetchFeedCommentEvent event,
      Emitter<DisplayFeedCommentState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final res = await _feedUseCase.fetchComments(
          feedId: _feedId, beforeAt: state.beforeAt, take: event.take);
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
          message: 'fetch comments fail'));
    }
  }

  Future<void> _onLike(
      LikeFeedCommentEvent event, Emitter<DisplayFeedCommentState> emit) async {
    try {
      emit(state.copyWith(emotionStatus: Status.loading));
      await _emotionUseCase.likeFeed(event.commentId).then((res) {
        emit(state.copyWith(
            emotionStatus: res.ok ? Status.success : Status.error,
            message: res.ok ? null : res.message));
      });
    } catch (error) {
      log('_onLike : ${error.toString()}');
      emit(state.copyWith(
          emotionStatus: Status.error, message: 'like feed comment fails'));
    }
  }

  Future<void> _onCancelLike(CancelLikeFeedCommentEvent event,
      Emitter<DisplayFeedCommentState> emit) async {
    try {
      emit(state.copyWith(emotionStatus: Status.loading));
      await _emotionUseCase.deleteById(event.emotionId).then((res) {
        emit(state.copyWith(
            emotionStatus: res.ok ? Status.success : Status.error,
            message: res.ok ? null : res.message));
      });
    } catch (error) {
      log('_onCancelLike : ${error.toString()}');
      emit(state.copyWith(
          emotionStatus: Status.error,
          message: 'cancel like on feed comment fails'));
    }
  }
}
