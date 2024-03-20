import 'package:injectable/injectable.dart';

import '../../../entity/result/result.entity.dart';
import '../../../repository/post/post.repository.dart';

@singleton
class CancelLikePostUseCase {
  final PostRepository _postRepository;

  CancelLikePostUseCase(this._postRepository);

  Future<ResultEntity<String>> call({
    required String poseId,
    required String likeId,
  }) async =>
      await _postRepository
          .cancelLikePost(postId: poseId, likeId: likeId)
          .then((res) => ResultEntity<String>.fromResponse(res));
}
