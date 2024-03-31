import 'package:fpdart/fpdart.dart';
import 'package:hot_place/data/entity/feed/feed.entity.dart';
import 'package:hot_place/domain/repository/feed/feed.repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failure.constant.dart';

@lazySingleton
class CreateFeedUseCase {
  final FeedRepository _repository;

  CreateFeedUseCase(this._repository);

  Future<Either<Failure, void>> call(FeedEntity feed) async {
    return await _repository.createFeed(feed);
  }
}
