import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/entity/feed/base/feed.entity.dart';

abstract class FeedRepository {
  Stream<List<FeedEntity>> get feedStream;

  Future<Either<Failure, List<FeedEntity>>> getFeedsByHashtag(String hashtag,
      {int skip = 0, int take = 100});

  Future<Either<Failure, void>> createFeed(FeedEntity feed);

  Future<Either<Failure, void>> modifyFeed(FeedEntity feed);

  Future<Either<Failure, void>> deleteFeedById(String feedId);

  Future<Either<Failure, List<String>>> uploadFeedImagesAndReturnDownloadLinks(
      {required String feedId, required List<File> images});
}
