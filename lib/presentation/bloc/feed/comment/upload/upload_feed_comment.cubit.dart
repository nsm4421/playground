import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/constant/status.dart';
import '../../../../../data/entity/feed/feed_comment.entity.dart';
import '../../../../../domain/usecase/module/feed/feed_comment.usecase.dart';
import 'upload_feed_comment.state.dart';

class UploadFeedCommentCubit extends Cubit<UploadFeedCommentState> {
  final FeedCommentUseCase _useCase;

  final String _feedId;

  UploadFeedCommentCubit(this._feedId, {required FeedCommentUseCase useCase})
      : _useCase = useCase,
        super(const UploadFeedCommentState());

  setContent(String content) => emit(state.copyWith(content: content));

  Future<void> upload() async {
    try {
      assert(_feedId == state.feedId);
      emit(state.copyWith(status: Status.loading));

      await _useCase
          .saveFeed(FeedCommentEntity(
              id: (const Uuid()).v4(),
              feedId: _feedId,
              content: state.content,
              createdAt: DateTime.now()))
          .then((res) => res.fold((l) => throw l.toCustomException(),
              (r) => emit(state.copyWith(status: Status.success))));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: Status.error, message: '댓글 작성 중 오류가 발생했습니다'));
    }
  }
}
