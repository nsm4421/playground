import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/domain/usecase/post/comment/create_post_comment.usecase.dart';
import 'package:hot_place/domain/usecase/post/comment/delete_post_comment.usecase.dart';
import 'package:hot_place/domain/usecase/post/comment/modify_post_comment.usecase.dart';
import 'package:hot_place/presentation/post/bloc/comment/post_comment.event.dart';
import 'package:hot_place/presentation/post/bloc/comment/post_comment.state.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../core/constant/response.constant.dart';

@injectable
class PostCommentBloc extends Bloc<PostCommentEvent, PostCommentState> {
  PostCommentBloc(
      {required CreatePostCommentUseCase createPostCommentUseCase,
      required ModifyPostCommentUseCase modifyPostCommentUseCase,
      required DeletePostCommentUseCase deletePostCommentUseCase})
      : _createPostCommentUseCase = createPostCommentUseCase,
        _modifyPostCommentUseCase = modifyPostCommentUseCase,
        _deletePostCommentUseCase = deletePostCommentUseCase,
        super(const PostCommentState()) {
    on<InitPostComment>(_onInit);
    on<InitChildComment>(_onInitChildComment);
    on<CreatePostComment>(_onCreateComment);
    on<ModifyPostComment>(_onModifyComment);
    on<DeletePostComment>(_onDeleteComment);
  }

  final _logger = Logger();
  final CreatePostCommentUseCase _createPostCommentUseCase;
  final ModifyPostCommentUseCase _modifyPostCommentUseCase;
  final DeletePostCommentUseCase _deletePostCommentUseCase;

  Future<void> _onInit(
    InitPostComment event,
    Emitter<PostCommentState> emit,
  ) async {
    throw UnimplementedError();
  }

  Future<void> _onInitChildComment(
    InitChildComment event,
    Emitter<PostCommentState> emit,
  ) async {
    throw UnimplementedError();
  }

  Future<void> _onCreateComment(
    CreatePostComment event,
    Emitter<PostCommentState> emit,
  ) async {
    try {
      emit(state.copyWith(
          status: Status.loading,
          postId: event.postId,
          parentCommentId: event.parentCommentId));
      (await _createPostCommentUseCase(
              postId: event.postId,
              parentCommentId: event.parentCommentId,
              content: event.content))
          .when(success: (data) {
        emit(state.copyWith(status: Status.success));
      }, failure: (code, description) {
        throw Exception("error-code:$code: ($description)");
      });
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onModifyComment(
    ModifyPostComment event,
    Emitter<PostCommentState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading, postId: event.postId));
      (await _modifyPostCommentUseCase(
              postId: event.postId,
              commentId: event.commentId,
              content: event.content))
          .when(success: (data) {
        emit(state.copyWith(status: Status.success));
      }, failure: (code, description) {
        throw Exception("error-code:$code: ($description)");
      });
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onDeleteComment(
    DeletePostComment event,
    Emitter<PostCommentState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading, postId: event.postId));
      (await _deletePostCommentUseCase(
              postId: event.postId, commentId: event.commentId))
          .when(success: (data) {
        emit(state.copyWith(status: Status.success));
      }, failure: (code, description) {
        throw Exception("error-code:$code: ($description)");
      });
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: Status.error));
    }
  }
}
