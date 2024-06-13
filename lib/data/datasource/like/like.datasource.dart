part of 'like.datasource_impl.dart';

abstract interface class LikeDataSource {}

abstract interface class LocalLikeDataSource implements LikeDataSource {}

abstract interface class RemoteLikeDataSource implements LikeDataSource {
  Future<void> like();

  Future<void> cancelLike(LikeModel user);
}
