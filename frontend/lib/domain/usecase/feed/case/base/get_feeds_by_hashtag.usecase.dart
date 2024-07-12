import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/failure.constant.dart';
import '../../../../../data/entity/feed/base/feed.entity.dart';
import '../../../../repository/feed/base/feed.repository.dart';

class GetFeedsByHashtag {
  final FeedRepository _repository;

  GetFeedsByHashtag(this._repository);

  Future<Either<Failure, List<FeedEntity>>> call(String hashtag,
      {int page = 1, int size = 20}) async {
    return await _repository.getFeedsByHashtag(hashtag,
        skip: (page - 1) * size, take: size);
  }
}
