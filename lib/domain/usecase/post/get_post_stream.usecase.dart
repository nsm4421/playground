import 'package:hot_place/domain/entity/post/post.entity.dart';
import 'package:hot_place/domain/entity/result/result.entity.dart';
import 'package:injectable/injectable.dart';

import '../../repository/post/post.repository.dart';

@singleton
class GetPostStreamUseCase {
  final PostRepository _postRepository;

  GetPostStreamUseCase(this._postRepository);

  ResultEntity<Stream<List<PostEntity>>> call({int skip = 0, int take = 100}) =>
      ResultEntity<Stream<List<PostEntity>>>.fromResponse(
          _postRepository.getPostStream(skip: skip, take: take));
}
