import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/entity/feed/feed.entity.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/repository/feed/feed.repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failure.constant.dart';

@lazySingleton
class CreateFeedUseCase {
  final FeedRepository _repository;

  CreateFeedUseCase(this._repository);

  Future<Either<Failure, void>> call(
      {required String content,
      required List<String> hashtags,
      required List<String> images,
      required UserEntity currentUser}) async {
    final id = UuidUtil.uuid();
    return await _repository.createFeed(FeedEntity(
        id: id,
        user: currentUser,
        content: content,
        hashtags: hashtags,
        images: images,
        createdAt: DateTime.now()));
  }
}
