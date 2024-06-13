part of 'like.datasource_impl.dart';

abstract interface class LikeDataSource {}

abstract interface class LocalLikeDataSource implements LikeDataSource {}

abstract interface class RemoteLikeDataSource implements LikeDataSource {
  Stream<Iterable<LikeModel>> get likeOnFeedStream;

  Future<void> saveLikeOnFeed(String feedId);

  Future<void> deleteLikeOnFeed(String feedId);

  Future<void> deleteLikeById(String likeId);
}
