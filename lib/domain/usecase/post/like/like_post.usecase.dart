import 'package:injectable/injectable.dart';

import '../../../entity/result/result.entity.dart';
import '../../../repository/post/post.repository.dart';

@singleton
class LikePostUseCase {
  final PostRepository _postRepository;

  LikePostUseCase(this._postRepository);

  Future<ResultEntity<String>> call(String postId) async =>
      await _postRepository
          .likePost(postId)
          .then((res) => ResultEntity<String>.fromResponse(res));
}
