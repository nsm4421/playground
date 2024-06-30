import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/exception/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../data/entity/feed/comment/feed_comment.entity.dart';
import '../../../../data/repository_impl/feed/feed_comment.repository_impl.dart';

part '../../case/feed/comment/fetch_feed_comments.usecase.dart';

part '../../case/feed/comment/save_feed_comment.usecase.dart';

part '../../case/feed/comment/modify_feed_comment.usecase.dart';

part '../../case/feed/comment/delete_feed_comment.usecase.dart';

part '../../case/feed/comment/get_comment_channel.usecase.dart';

@lazySingleton
class FeedCommentUseCase {
  final FeedCommentRepository _repository;

  FeedCommentUseCase(this._repository);

  @injectable
  FetchFeedCommentsUseCase get fetchComments =>
      FetchFeedCommentsUseCase(_repository);

  @injectable
  SaveFeedCommentUseCase get saveFeed => SaveFeedCommentUseCase(_repository);

  @injectable
  ModifyFeedCommentUseCase get modify => ModifyFeedCommentUseCase(_repository);

  @injectable
  DeleteFeedCommentUseCase get delete => DeleteFeedCommentUseCase(_repository);

  @injectable
  GetCommentChannel get channel => GetCommentChannel(_repository);
}
