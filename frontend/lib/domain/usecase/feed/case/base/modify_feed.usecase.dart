import 'package:fpdart/fpdart.dart';
import 'package:hot_place/data/entity/feed/base/feed.entity.dart';
import 'package:hot_place/domain/repository/feed/base/feed.repository.dart';
import '../../../../../core/error/failure.constant.dart';

class ModifyFeedUseCase {
  final FeedRepository _repository;

  ModifyFeedUseCase(this._repository);

  Future<Either<Failure, void>> call(FeedEntity feed) async {
    return await _repository.modifyFeed(feed);
  }
}
