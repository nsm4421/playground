import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/entity/feed/base/feed.entity.dart';
import 'package:my_app/domain/usecase/module/feed/feed_comment.usecase.dart';

import '../../../../../core/exception/custom_exception.dart';
import '../../../../../data/entity/feed/comment/feed_comment.entity.dart';

part 'display_feed_comment.event.dart';

part 'display_feed_comment.state.dart';

class DisplayFeedCommentBloc
    extends Bloc<DisplayFeedCommentEvent, DisplayFeedCommentState> {
  final FeedEntity _feed;
  final FeedCommentUseCase _useCase;
  DateTime _beforeAt = DateTime.now();
  int _page = 0;
  bool _isEnd = false;
  static const int _pageSize = 10;

  DisplayFeedCommentBloc(
      {required FeedEntity feed, required FeedCommentUseCase useCase})
      : _feed = feed,
        _useCase = useCase,
        super(InitialDisplayFeedCommentState()) {
    on<InitDisplayFeedCommentEvent>(_onInit);
    on<FetchDisplayFeedCommentEvent>(_onFetch);
    on<ModifyDisplayFeedCommentEvent>(_onModify);
    on<DeleteDisplayFeedCommentEvent>(_onDelete);
  }

  bool get isEnd => _isEnd;

  Future<void> _onInit(InitDisplayFeedCommentEvent event,
      Emitter<DisplayFeedCommentState> emit) async {
    try {
      _beforeAt = DateTime.now();
      _page = 0;
      _isEnd = false;
      emit(InitialDisplayFeedCommentState());
    } catch (error) {
      log(error.toString());
      emit(DisplayFeedCommentFailureState(
          (error is CustomException) ? error.message : '알 수 없는 오류 발생'));
    }
  }

  Future<void> _onFetch(FetchDisplayFeedCommentEvent event,
      Emitter<DisplayFeedCommentState> emit) async {
    try {
      if (_isEnd) {
        emit(FeedCommentFetchedState(fetched: const [], isEnd: true));
        return;
      } else {
        emit(DisplayFeedCommentLoadingState());
        _page += 1;
        final from = (_page - 1) * _pageSize;
        final to = _page * _pageSize - 1;
        final res = await _useCase.fetchComments(
            beforeAt: _beforeAt, from: from, to: to, feedId: _feed.id!);
        res.fold((l) => throw l.toCustomException(message: '피드 댓글 목록 조회 실패'),
            (r) {
          _isEnd = r.length < _pageSize;
          emit(FeedCommentFetchedState(fetched: r, isEnd: true));
        });
      }
    } catch (error) {
      log(error.toString());
      emit(DisplayFeedCommentFailureState(
          (error is CustomException) ? error.message : '알 수 없는 오류 발생'));
    }
  }

  Future<void> _onModify(ModifyDisplayFeedCommentEvent event,
      Emitter<DisplayFeedCommentState> emit) async {
    try {
      emit(DisplayFeedCommentLoadingState());
      await _useCase.modify(event.comment).then((res) => res.fold(
          (l) => l.toCustomException(message: '댓글 수정 실패'),
          (r) => emit(DisplayFeedCommentSuccessState())));
    } catch (error) {
      log(error.toString());
      emit(DisplayFeedCommentFailureState(
          (error is CustomException) ? error.message : '알 수 없는 오류 발생'));
    }
  }

  Future<void> _onDelete(DeleteDisplayFeedCommentEvent event,
      Emitter<DisplayFeedCommentState> emit) async {
    try {
      emit(DisplayFeedCommentLoadingState());
      await _useCase.delete(event.comment).then((res) => res.fold(
          (l) => l.toCustomException(message: '댓글 삭제 실패'),
          (r) => emit(DisplayFeedCommentSuccessState())));
    } catch (error) {
      log(error.toString());
      emit(DisplayFeedCommentFailureState(
          (error is CustomException) ? error.message : '알 수 없는 오류 발생'));
    }
  }
}
