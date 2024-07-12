import 'package:fpdart/src/either.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/feed/like/remote_data_source.dart';
import 'package:hot_place/data/entity/feed/like/like_feed.entity.dart';
import 'package:hot_place/domain/repository/feed/like/like_feed.repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/custom_exception.dart';

@LazySingleton(as: LikeFeedRepository)
class LikeFeedRepositoryImpl extends LikeFeedRepository {
  final RemoteLikeFeedDataSource _likeFeedDataSource;

  LikeFeedRepositoryImpl(RemoteLikeFeedDataSource likeFeedDataSource)
      : _likeFeedDataSource = likeFeedDataSource;

  @override
  Stream<Iterable<LikeFeedEntity>> getLikeStream() => _likeFeedDataSource
      .getLikeStream()
      .asyncMap((e) => e.map(LikeFeedEntity.fromModel));

  @override
  Future<Either<Failure, void>> likeFeed(String feedId) async {
    try {
      await _likeFeedDataSource.likeFeed(feedId);
      return right(null);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> cancelLike(String feedId) async {
    try {
      await _likeFeedDataSource.cancelLike(feedId);
      return right(null);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }
}
