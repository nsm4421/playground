import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/failure.constant.dart';
import '../../../../repository/feed/comment/feed_comment.repository.dart';

class DeleteFeedCommentUseCase {
  final FeedCommentRepository _repository;

  DeleteFeedCommentUseCase(this._repository);

  Future<Either<Failure, void>> call(String commentId) async {
    return await _repository.deleteFeedCommentById(commentId);
  }
}
