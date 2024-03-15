import 'package:hot_place/domain/entity/result/result.entity.dart';
import 'package:hot_place/domain/repository/post/post.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class DeletePostUseCase {
  final PostRepository _postRepository;

  DeletePostUseCase({
    required PostRepository postRepository,
  }) : _postRepository = postRepository;

  Future<ResultEntity<void>> call(String postId) async => await _postRepository
      .deletePostById(postId)
      .then((res) => ResultEntity<String>.fromResponse(res));
}
