import 'package:hot_place/domain/entity/post/comment/post_comment.entity.dart';
import 'package:injectable/injectable.dart';

import '../../../entity/result/result.entity.dart';
import '../../../repository/post/post.repository.dart';

@singleton
class CreatePostCommentUseCase {
  final PostRepository _postRepository;

  CreatePostCommentUseCase(this._postRepository);

  Future<ResultEntity<String>> call(
          {required String postId,
          String? parentCommentId,
          required String content}) async =>
      await _postRepository
          .createPostComment(PostCommentEntity(
              postId: postId,
              parentCommentId: parentCommentId,
              content: content,
              createdAt: DateTime.now()))
          .then((res) => ResultEntity<String>.fromResponse(res));
}
