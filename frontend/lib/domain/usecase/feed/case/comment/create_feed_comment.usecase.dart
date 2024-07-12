import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/entity/feed/comment/feed_comment.entity.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

import '../../../../../core/error/failure.constant.dart';
import '../../../../repository/feed/comment/feed_comment.repository.dart';

class CreateFeedCommentUseCase {
  final FeedCommentRepository _repository;

  CreateFeedCommentUseCase(this._repository);

  Future<Either<Failure, void>> call({
    required String feedId,
    required String content,
    required UserEntity currentUser,
  }) async {
    final comment = FeedCommentEntity(
        id: UuidUtil.uuid(),
        feedId: feedId,
        author: currentUser,
        content: content,
        createdAt: DateTime.now());
    return await _repository.upsertFeedComment(comment);
  }
}
