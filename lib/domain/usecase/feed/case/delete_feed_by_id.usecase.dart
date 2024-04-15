import 'package:fpdart/fpdart.dart';
import 'package:hot_place/domain/repository/feed/feed.repository.dart';

import '../../../../core/error/failure.constant.dart';

class DeleteFeedByIdUseCase {
  final FeedRepository _repository;

  DeleteFeedByIdUseCase(this._repository);

  Future<Either<Failure, void>> call(String feedId) async =>
      await _repository.deleteFeedById(feedId);
}
