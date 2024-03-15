import 'package:hot_place/domain/entity/post/post.entity.dart';
import 'package:hot_place/domain/entity/result/result.entity.dart';
import 'package:hot_place/domain/repository/post/post.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class FindPostByIdUseCase {
  final PostRepository _postRepository;

  FindPostByIdUseCase(this._postRepository);

  Future<ResultEntity<PostEntity>> call({required String postId}) async =>
      await _postRepository
          .findPostById(postId)
          .then((res) => ResultEntity<PostEntity>.fromResponse(res));
}
