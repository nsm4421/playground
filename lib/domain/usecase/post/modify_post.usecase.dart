import 'package:hot_place/domain/entity/post/post.entity.dart';
import 'package:hot_place/domain/repository/post/post.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class ModifyPostUseCase {
  final PostRepository _postRepository;

  ModifyPostUseCase(this._postRepository);

  Future<void> call(
      {required String postId,
      required String content,
      required List<String> hashtags,
      required List<String> images}) async {
    final PostEntity post = PostEntity(
        id: postId,
        content: content,
        hashtags: hashtags,
        images: images,
        createdAt: DateTime.now());
    await _postRepository.modifyPost(post);
  }
}
