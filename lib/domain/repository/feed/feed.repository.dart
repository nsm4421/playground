import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/entity/feed/feed.entity.dart';

abstract class FeedRepository {
  Either<Failure, Stream<List<FeedEntity>>> getFeedStream();

  Future<Either<Failure, List<FeedEntity>>> getFeeds(
      {required int skip, required int take});

  Future<Either<Failure, void>> createFeed(FeedEntity feed);

  Future<Either<Failure, void>> modifyFeed(FeedEntity feed);

  Future<Either<Failure, void>> deleteFeedById(String feedId);

  Future<Either<Failure, List<String>>> uploadFeedImagesAndReturnDownloadLinks(
      {required String feedId, required List<File> images});
}
