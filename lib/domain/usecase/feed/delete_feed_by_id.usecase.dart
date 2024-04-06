import 'package:fpdart/fpdart.dart';
import 'package:hot_place/domain/repository/feed/feed.repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failure.constant.dart';

@lazySingleton
class DeleteFeedByIdUseCase {
  final FeedRepository _repository;

  DeleteFeedByIdUseCase(this._repository);

  Future<Either<Failure, void>> call(String feedId) async {
    return await _repository.deleteFeedById(feedId);
  }
}
