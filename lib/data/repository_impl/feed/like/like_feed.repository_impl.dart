import 'package:fpdart/src/either.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/feed/like/like_feed.data_source.dart';
import 'package:hot_place/data/entity/feed/like/like_feed.entity.dart';
import 'package:hot_place/domain/repository/feed/like/like_feed.repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/custom_exception.dart';
import '../../../../domain/model/feed/like/like_feed.model.dart';

@Singleton(as: LikeFeedRepository)
class LikeFeedRepositoryImpl extends LikeFeedRepository {
  final RemoteLikeFeedDataSource _likeFeedDataSource;

  LikeFeedRepositoryImpl(RemoteLikeFeedDataSource likeFeedDataSource)
      : _likeFeedDataSource = likeFeedDataSource;

  @override
  Stream<LikeFeedEntity?> getLikeStream(String feedId) => _likeFeedDataSource
      .getLikeStream(feedId)
      .map((event) => event != null ? LikeFeedEntity.fromModel(event) : null);

  @override
  Future<Either<Failure, String>> likeFeed(String feedId) async {
    try {
      final likeId = await _likeFeedDataSource.likeFeed(feedId);
      return right(likeId);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> cancelLikeById(String likeId) async {
    try {
      await _likeFeedDataSource.cancelLikeById(likeId);
      return right(null);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }
}
