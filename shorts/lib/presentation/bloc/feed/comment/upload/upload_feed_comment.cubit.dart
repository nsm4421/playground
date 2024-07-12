import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/data/entity/feed/base/feed.entity.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/constant/status.dart';
import '../../../../../data/entity/feed/comment/feed_comment.entity.dart';
import '../../../../../domain/usecase/module/feed/feed_comment.usecase.dart';
import 'upload_feed_comment.state.dart';

class UploadFeedCommentCubit extends Cubit<UploadFeedCommentState> {
  final FeedCommentUseCase _useCase;
  final FeedEntity _feed;

  UploadFeedCommentCubit(
      {required FeedEntity feed, required FeedCommentUseCase useCase})
      : _feed = feed,
        _useCase = useCase,
        super(UploadFeedCommentState(feedId: feed.id!));

  setContent(String content) => emit(state.copyWith(content: content));

  Future<void> upload() async {
    try {
      assert(_feed.id == state.feedId);
      emit(state.copyWith(status: Status.loading));

      await _useCase
          .saveFeed(FeedCommentEntity(
              id: (const Uuid()).v4(),
              feedId: _feed.id,
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
