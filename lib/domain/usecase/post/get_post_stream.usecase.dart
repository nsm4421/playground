import 'package:hot_place/domain/entity/post/post.entity.dart';
import 'package:injectable/injectable.dart';

import '../../repository/post/post.repository.dart';

@singleton
class GetPostStreamUseCase {
  final PostRepository _postRepository;

  GetPostStreamUseCase(this._postRepository);

  Stream<List<PostEntity>> call({int skip = 0, int take = 100}) =>
      _postRepository.getPostStream(skip: skip, take: take);
}
