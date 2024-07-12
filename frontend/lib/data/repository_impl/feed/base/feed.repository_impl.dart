import 'dart:io';

import 'package:fpdart/src/either.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/feed/base/remote_data_source.dart';
import 'package:hot_place/data/entity/feed/base/feed.entity.dart';
import 'package:hot_place/domain/model/feed/base/feed.model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/custom_exception.dart';
import '../../../../domain/repository/feed/base/feed.repository.dart';

@LazySingleton(as: FeedRepository)
class FeedRepositoryImpl extends FeedRepository {
  final RemoteFeedDataSource _remoteFeedDataSource;

  FeedRepositoryImpl(RemoteFeedDataSource feedDataSource)
      : _remoteFeedDataSource = feedDataSource;

  @override
  Stream<List<FeedEntity>> get feedStream => _remoteFeedDataSource
      .getFeedStream()
      .map((data) => data.map((model) => FeedEntity.fromModel(model)).toList());

  @override
  Future<Either<Failure, List<FeedEntity>>> getFeedsByHashtag(String hashtag,
      {int skip = 0, int take = 100}) async {
    try {
      return await _remoteFeedDataSource
          .getFeedsByHashtag(hashtag, skip: skip, take: take)
          .then(
              (data) => data.map((feed) => FeedEntity.fromModel(feed)).toList())
          .then((res) => right(res));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> createFeed(FeedEntity feed) async {
    try {
      return await _remoteFeedDataSource
          .createFeed(FeedModel.fromEntity(feed))
          .then((_) => right(null));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFeedById(String feedId) async {
    try {
      return await _remoteFeedDataSource
          .deleteFeedById(feedId)
          .then((_) => right(null));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> modifyFeed(FeedEntity feed) async {
    try {
      return await _remoteFeedDataSource
          .modifyFeed(FeedModel.fromEntity(feed))
          .then((_) => right(null));
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
              await _remoteFeedDataSource.uploadFeedImageAndReturnDownloadLink(
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
