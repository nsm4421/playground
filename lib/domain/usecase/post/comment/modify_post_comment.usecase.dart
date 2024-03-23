import 'package:hot_place/domain/entity/post/comment/post_comment.entity.dart';
import 'package:injectable/injectable.dart';

import '../../../entity/result/result.entity.dart';
import '../../../repository/post/post.repository.dart';

@singleton
class ModifyPostCommentUseCase {
  final PostRepository _postRepository;

  ModifyPostCommentUseCase(this._postRepository);

  Future<ResultEntity<String>> call(
          {required String postId,
          required String commentId,
          String? parentCommentId,
          required String content}) async =>
      await _postRepository
          .modifyPostComment(PostCommentEntity(
              id: commentId,
              postId: postId,
              parentCommentId: parentCommentId,
              content: content))
          .then((res) => ResultEntity<String>.fromResponse(res));
}
