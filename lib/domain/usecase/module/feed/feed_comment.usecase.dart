import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/exception/failure.dart';

import '../../../../data/entity/feed/feed_comment.entity.dart';
import '../../../../data/repository_impl/feed/feed_comment.repository_impl.dart';

part '../../case/feed/comment/get_feed_comment_stream.usecase.dart';

part '../../case/feed/comment/save_feed_comment.usecase.dart';

@lazySingleton
class FeedCommentUseCase {
  final FeedCommentRepository _repository;

  FeedCommentUseCase(this._repository);

  @injectable
  GetFeedCommentStreamUseCase get commentStream =>
      GetFeedCommentStreamUseCase(_repository);

  @injectable
  SaveFeedCommentUseCase get saveFeed => SaveFeedCommentUseCase(_repository);
}
