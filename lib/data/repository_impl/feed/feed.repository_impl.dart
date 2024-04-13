import 'dart:io';

import 'package:fpdart/src/either.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/feed/feed.data_source.dart';
import 'package:hot_place/data/entity/feed/feed.entity.dart';
import 'package:hot_place/domain/model/feed/feed.model.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/custom_exception.dart';
import '../../../domain/repository/feed/feed.repository.dart';

@Singleton(as: FeedRepository)
class FeedRepositoryImpl extends FeedRepository {
  final FeedDataSource _feedDataSource;

  FeedRepositoryImpl(FeedDataSource feedDataSource)
      : _feedDataSource = feedDataSource;

  @override
  Stream<List<FeedEntity>> get feedStream => _feedDataSource
      .getFeedStream()
      .map((data) => data.map((model) => FeedEntity.fromModel(model)).toList());

  @override
  Future<Either<Failure, List<FeedEntity>>> getFeeds(
      {required int skip, required int take}) async {
    try {
      final feeds = await _feedDataSource.getFeeds(skip: skip, take: take).then(
          (data) => data.map((feed) => FeedEntity.fromModel(feed)).toList());
      return right(feeds);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> createFeed(FeedEntity feed) async {
    try {
      await _feedDataSource.createFeed(FeedModel.fromEntity(feed));
      return right(null);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFeedById(String feedId) async {
    try {
      await _feedDataSource.deleteFeedById(feedId);
      return right(null);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> modifyFeed(FeedEntity feed) async {
    try {
      await _feedDataSource.modifyFeed(FeedModel.fromEntity(feed));
      return right(null);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> uploadFeedImagesAndReturnDownloadLinks(
      {required String feedId, required List<File> images}) async {
    try {
      final futures = List.generate(
          images.length,
          (index) async =>
              await _feedDataSource.uploadFeedImageAndReturnDownloadLink(
                  feedId: feedId,
                  filename: '$feedId-$index',
                  image: images[index]));
      final downloadLinks = await Future.wait(futures);
      return right(downloadLinks);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }
}
