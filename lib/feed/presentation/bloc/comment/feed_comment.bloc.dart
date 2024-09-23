import 'dart:developer';

import 'package:flutter_app/feed/domain/domain.export.dart';
import 'package:flutter_app/feed/domain/entity/feed_comment.entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/shared.export.dart';

part 'feed_comment.state.dart';

part 'feed_comment.event.dart';

@injectable
class FeedCommentBloc extends Bloc<FeedCommentEvent, FeedCommentState> {
  final FeedUseCase _useCase;
  final String _feedId;

  FeedCommentBloc(@factoryParam this._feedId, {required FeedUseCase useCase})
      : _useCase = useCase,
        super(FeedCommentState(feedId: _feedId)) {
    on<InitFeedCommentEvent>(_onInit);
    on<WriteParentFeedCommentEvent>(_onWriteParentComment);
    on<WriteChildFeedCommentEvent>(_onWriteChildComment);
    on<FetchParentFeedCommentEvent>(_onFetchParentComments);
    on<FetchChildFeedCommentEvent>(_onFetchChildComments);
    on<DeleteParentFeedCommentEvent>(_onDeleteParentComment);
    on<DeleteChildFeedCommentEvent>(_onDeleteChildComment);
    on<SelectParentCommentEvent>(_onSelectParentComment);
    on<UnSelectParentCommentEvent>(_onUnSelectParentComment);
  }

  String get feedId => _feedId;

  // 댓글 조회 시 작성시간이 beforeAt보다 이전인 댓글만 조회
  DateTime getBeforeAt({String? parentId}) {
    if (parentId == null) {
      // 부모댓글의 조회 기준시간
      return state.comments.isEmpty
          ? DateTime.now().toUtc()
          : state.comments
              .map((item) => item.createdAt!)
              .reduce((r, l) => r.isBefore(l) ? r : l);
    } else {
      // 자식댓글의 조회 기준시간
      final children =
          state.comments.where((item) => item.id == parentId).first.children;
      return children.isEmpty
          ? DateTime.now().toUtc()
          : children
              .map((item) => item.createdAt!)
              .reduce((r, l) => r.isBefore(l) ? r : l);
    }
  }

  Future<void> _onInit(
      InitFeedCommentEvent event, Emitter<FeedCommentState> emit) async {
    log('[FeedCommentBloc]_onInit실행');
    emit(state.copyWith(
        isMounted: event.isMounted ?? state.isMounted,
        status: event.status ?? state.status,
        errorMessage: event.errorMessage ?? state.errorMessage));
  }

  Future<void> _onWriteParentComment(
      WriteParentFeedCommentEvent event, Emitter<FeedCommentState> emit) async {
    try {
      log('[FeedCommentBloc]_onWriteParentComment실행');
      emit(state.copyWith(status: Status.loading));
      final res = await _useCase.createParentComment(
          feedId: feedId, content: event.content);
      log('[FeedCommentBloc]부모댓글 작성 요청 ok:${res.ok} message:${res.message}');
      if (res.ok) {
        emit(state.copyWith(status: Status.success));
      } else {
        emit(state.copyWith(status: Status.error, errorMessage: res.message));
      }
    } catch (error) {
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onWriteChildComment(
      WriteChildFeedCommentEvent event, Emitter<FeedCommentState> emit) async {
    try {
      log('[FeedCommentBloc]_onWriteChildComment실행');
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .createChildComment(
              feedId: feedId, parentId: event.parentId, content: event.content)
          .then((res) {
        log('[FeedCommentBloc]자식댓글 작성 요청 ok:${res.ok} message:${res.message}');
        if (res.ok) {
          emit(state.copyWith(status: Status.success));
        } else {
          emit(state.copyWith(
              status: Status.error, errorMessage: '댓글을 작성  오류가 발생했습니다'));
        }
      });
    } catch (error) {
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onFetchParentComments(
      FetchParentFeedCommentEvent event, Emitter<FeedCommentState> emit) async {
    try {
      log('[FeedCommentBloc]_onFetchParentComments실행');
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .fetchParentComment(
              feedId: feedId, beforeAt: getBeforeAt(), take: event.take)
          .then((res) {
        log('[FeedCommentBloc]댓글 가져오기 요청 ok:${res.ok} message:${res.message}');
        if (res.ok) {
          emit(state.copyWith(status: Status.success, comments: [
            ...state.comments,
            ...res.data!
          ], isEndMap: {
            ...state.isEndMap,
            feedId: res.data!.length < event.take
          }));
        } else {
          emit(state.copyWith(status: Status.error, errorMessage: res.message));
        }
      });
    } catch (error) {
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onFetchChildComments(
      FetchChildFeedCommentEvent event, Emitter<FeedCommentState> emit) async {
    try {
      log('[FeedCommentBloc]_onFetchChildComments실행');
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .fetchChildComment(
              feedId: feedId,
              parentId: event.parentId,
              beforeAt: getBeforeAt(parentId: event.parentId),
              take: event.take)
          .then((res) {
        log('[FeedCommentBloc]대댓글 가져오기 요청 ok:${res.ok} message:${res.message}');
        if (res.ok) {
          emit(state.copyWith(
              status: Status.success,
              comments: state.comments
                  .map((item) => item.id == event.parentId
                      ? item
                          .copyWith(children: [...item.children, ...res.data!])
                      : item)
                  .toList(),
              isEndMap: {
                ...state.isEndMap,
                event.parentId: res.data!.length < event.take
              }));
        } else {
          emit(state.copyWith(
              status: Status.error, errorMessage: '댓글을 가져오는 중 오류가 발생했습니다'));
        }
      });
    } catch (error) {
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onDeleteParentComment(DeleteParentFeedCommentEvent event,
      Emitter<FeedCommentState> emit) async {
    try {
      log('[FeedCommentBloc]_onDeleteParentComment실행');
      emit(state.copyWith(status: Status.loading));
      await _useCase.deleteComment(event.commentId).then((res) {
        log('[FeedCommentBloc]댓글 삭제하기 요청 ok:${res.ok} message:${res.message}');
        if (res.ok) {
          emit(state.copyWith(
              status: Status.success,
              comments: [...state.comments]
                  .where((item) => item.id != event.commentId)
                  .toList()));
        } else {
          emit(state.copyWith(status: Status.error, errorMessage: res.message));
        }
      });
    } catch (error) {
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onDeleteChildComment(
      DeleteChildFeedCommentEvent event, Emitter<FeedCommentState> emit) async {
    try {
      log('[FeedCommentBloc]_onDeleteChildComment실행');
      emit(state.copyWith(status: Status.loading));
      await _useCase.deleteComment(event.commentId).then((res) {
        log('[FeedCommentBloc]대댓글 삭제하기 요청 ok:${res.ok} message:${res.message}');
        if (res.ok) {
          emit(state.copyWith(
              status: Status.success,
              comments: [...state.comments]
                  .map((parentComment) => parentComment.id == event.parentId
                      ? parentComment.copyWith(
                          children: [...parentComment.children]
                              .where((childComment) =>
                                  childComment.id != event.commentId)
                              .toList())
                      : parentComment)
                  .toList()));
        } else {
          emit(state.copyWith(status: Status.error, errorMessage: res.message));
        }
      });
    } catch (error) {
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onSelectParentComment(
      SelectParentCommentEvent event, Emitter<FeedCommentState> emit) async {
    try {
      log('[FeedCommentBloc]_onSelectParentComment실행');
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .fetchChildComment(
              feedId: feedId,
              parentId: event.parentComment.id!,
              beforeAt: getBeforeAt(parentId: event.parentComment.id!),
              take: event.take)
          .then((res) {
        log('[FeedCommentBloc]부모댓글 선택하기 요청 ok:${res.ok} message:${res.message}');
        if (res.ok) {
          emit(state.copyWith(
              parentComment: event.parentComment,
              status: Status.success,
              comments: state.comments
                  .map((item) => item.id == event.parentComment.id!
                      ? item.copyWith(children: [...res.data!])
                      : item)
                  .toList(),
              isEndMap: {
                ...state.isEndMap,
                event.parentComment.id!: res.data!.length < event.take
              }));
        } else {
          emit(state.copyWith(
              status: Status.error, errorMessage: '댓글을 가져오는 중 오류가 발생했습니다'));
        }
      });
    } catch (error) {
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onUnSelectParentComment(
      UnSelectParentCommentEvent event, Emitter<FeedCommentState> emit) async {
    try {
      log('[FeedCommentBloc]_onUnSelectParentComment요청');
      emit(state.copyWith(parentComment: null));
    } catch (error) {
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }
}
