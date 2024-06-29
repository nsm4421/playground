part of '../impl/like.remote_datasource_impl.dart';

abstract interface class RemoteLikeDataSource {
  Stream<Iterable<LikeModel>> get likeOnFeedStream;

  Future<void> saveLikeOnFeed(String feedId);

  Future<void> deleteLikeOnFeed(String feedId);

  Future<void> deleteLikeById(String likeId);
}
