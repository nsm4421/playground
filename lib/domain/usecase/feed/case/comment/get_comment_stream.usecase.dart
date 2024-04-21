import 'package:fpdart/fpdart.dart';
import 'package:hot_place/data/entity/feed/comment/feed_comment.entity.dart';
import 'package:hot_place/domain/repository/feed/comment/feed_comment.repository.dart';

import '../../../../../core/error/failure.constant.dart';

class GetCommentStreamUseCase {
  final FeedCommentRepository _repository;

  GetCommentStreamUseCase(this._repository);

  Either<Failure, Stream<List<FeedCommentEntity>>> call(String feedId) =>
      _repository.getFeedCommentStream(feedId);
}
