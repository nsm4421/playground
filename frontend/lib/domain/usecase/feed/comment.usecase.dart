import 'package:hot_place/domain/usecase/feed/case/comment/delete_feed_comment.usecase.dart';
import 'package:hot_place/domain/usecase/feed/case/comment/get_comment_stream.usecase.dart';
import 'package:hot_place/domain/usecase/feed/case/comment/modify_feed_comment.usecase.dart';
import 'package:hot_place/domain/usecase/feed/case/comment/create_feed_comment.usecase.dart';
import 'package:injectable/injectable.dart';

import '../../repository/feed/comment/feed_comment.repository.dart';

@lazySingleton
class FeedCommentUseCase {
  final FeedCommentRepository _repository;

  FeedCommentUseCase(this._repository);

  @injectable
  GetCommentStreamUseCase get commentStream =>
      GetCommentStreamUseCase(_repository);

  @injectable
  CreateFeedCommentUseCase get createComment =>
      CreateFeedCommentUseCase(_repository);

  @injectable
  ModifyFeedCommentUseCase get modifyComment =>
      ModifyFeedCommentUseCase(_repository);

  @injectable
  DeleteFeedCommentUseCase get deleteComment =>
      DeleteFeedCommentUseCase(_repository);
}
