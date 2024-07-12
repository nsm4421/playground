import 'package:fpdart/fpdart.dart';
import 'package:hot_place/data/entity/feed/comment/feed_comment.entity.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

import '../../../../../core/error/failure.constant.dart';
import '../../../../repository/feed/comment/feed_comment.repository.dart';

class ModifyFeedCommentUseCase {
  final FeedCommentRepository _repository;

  ModifyFeedCommentUseCase(this._repository);

  Future<Either<Failure, void>> call({
    required String commentId,
    required String feedId,
    required String content,
    required UserEntity currentUser,
  }) async {
    final comment = FeedCommentEntity(
        id: commentId,
        feedId: feedId,
        author: currentUser,
        content: content,
        createdAt: DateTime.now());
    return await _repository.upsertFeedComment(comment);
  }
}
