import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.constant.dart';
import '../../../../data/entity/feed/feed.entity.dart';
import '../../../repository/feed/feed.repository.dart';

class GetFeedsUseCase {
  final FeedRepository _repository;

  GetFeedsUseCase(this._repository);

  Future<Either<Failure, List<FeedEntity>>> call(
      {int page = 1, int size = 20}) async {
    return await _repository.getFeeds(skip: (page - 1) * size, take: size);
  }
}
