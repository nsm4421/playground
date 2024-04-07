import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failure.constant.dart';
import '../../../data/entity/feed/feed.entity.dart';
import '../../repository/feed/feed.repository.dart';

@lazySingleton
class GetFeedStreamUseCase {
  final FeedRepository _repository;

  GetFeedStreamUseCase(this._repository);

  Either<Failure, Stream<List<FeedEntity>>> call() {
    return _repository.getFeedStream();
  }
}
