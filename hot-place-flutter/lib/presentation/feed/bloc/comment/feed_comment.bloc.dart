import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/core/constant/notification.constant.dart';
import 'package:hot_place/domain/usecase/feed/comment.usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/entity/feed/base/feed.entity.dart';
import '../../../../data/entity/feed/comment/feed_comment.entity.dart';
import '../../../../data/entity/user/user.entity.dart';
import '../../../../domain/usecase/notification/notification.usecase.dart';

part 'feed_comment.state.dart';

part 'feed_comment.event.dart';

@injectable
class FeedCommentBloc extends Bloc<FeedCommentEvent, FeedCommentState> {
  late Stream<List<FeedCommentEntity>> _commentStream;
  late String _feedId;

  Stream<List<FeedCommentEntity>> get commentStream => _commentStream;

  final FeedCommentUseCase _feedUseCase;
  final NotificationUseCase _notificationUseCase;

  FeedCommentBloc(
      {required FeedCommentUseCase feedUseCase,
      required NotificationUseCase notificationUseCase})
      : _feedUseCase = feedUseCase,
        _notificationUseCase = notificationUseCase,
        super(InitialFeedCommentState()) {
    on<InitFeedCommentStateEvent>(_onInit);
    on<CreateFeedCommentEvent>(_onCreate);
    on<ModifyFeedCommentEvent>(_onModify);
    on<DeleteFeedCommentEvent>(_onDelete);
  }

  void _onInit(
      InitFeedCommentStateEvent event, Emitter<FeedCommentState> emit) async {
    emit(FeedCommentLoadingState());
    _feedId = event.feedId;
    // 댓글 스트림 초기화
    _feedUseCase.commentStream.call(_feedId).fold(
        (l) =>
            emit(FeedCommentFailureState(l.message ?? '댓글목록을 가져오는데 실패하였습니다')),
        (r) {
      _commentStream = r;
      emit(FeedCommentSuccessState());
    });
  }

  void _onCreate(
      CreateFeedCommentEvent event, Emitter<FeedCommentState> emit) async {
    // 댓글 작성
    try {
      emit(FeedCommentLoadingState());
      final res = await _feedUseCase.createComment(
          feedId: _feedId,
          currentUser: event._currentUser,
          content: event._content);
      res.fold(
          (l) =>
              emit(FeedCommentFailureState(l.message ?? '댓글 작성 요청이 실패하였습니다')),
          (r) {
        emit(FeedCommentSuccessState());
      });
    } catch (err) {
      debugPrint(err.toString());
      emit(const FeedCommentFailureState('댓글 작성 요청이 실패하였습니다'));
    }
    // 알림
    try {
      if (event._currentUser.id != event._feed.user.id) {
        await _notificationUseCase.create(
            message: '${event._currentUser.nickname}님이 댓글을 작성하였습니다',
            receiverId: event._feed.user.id!,
            createdBy: event._currentUser.id!,
            type: NotificationType.comment);
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  void _onModify(
      ModifyFeedCommentEvent event, Emitter<FeedCommentState> emit) async {
    emit(FeedCommentLoadingState());
    final res = await _feedUseCase.modifyComment(
        commentId: event.commentId,
        feedId: _feedId,
        currentUser: event.currentUser,
        content: event.content);
    res.fold(
        (l) => emit(FeedCommentFailureState(l.message ?? '댓글 작성 요청이 실패하였습니다')),
        (r) {
      emit(FeedCommentSuccessState());
    });
  }

  void _onDelete(
      DeleteFeedCommentEvent event, Emitter<FeedCommentState> emit) async {
    emit(FeedCommentLoadingState());
    final res = await _feedUseCase.deleteComment(event.commentId);
    res.fold(
        (l) => emit(FeedCommentFailureState(l.message ?? '댓글 삭제 요청이 실패하였습니다')),
        (r) {
      emit(FeedCommentSuccessState());
    });
  }
}
