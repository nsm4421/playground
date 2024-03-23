import 'package:injectable/injectable.dart';

import '../../../entity/result/result.entity.dart';
import '../../../repository/post/post.repository.dart';

@singleton
class DeletePostCommentUseCase {
  final PostRepository _postRepository;

  DeletePostCommentUseCase(this._postRepository);

  Future<ResultEntity<String>> call(
          {required String postId, required String commentId}) async =>
      await _postRepository
          .deletePostCommentById(postId: postId, commentId: commentId)
          .then((res) => ResultEntity<String>.fromResponse(res));
}
