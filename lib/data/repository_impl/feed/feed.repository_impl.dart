import 'dart:developer';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/datasource/feed/feed.datasource_impl.dart';
import 'package:my_app/data/entity/feed/feed.entity.dart';
import 'package:my_app/domain/model/feed/feed.model.dart';

import '../../../core/exception/custom_exception.dart';
import '../../../core/exception/failure.dart';

part 'package:my_app/domain/repository/feed/feed.repository.dart';

@LazySingleton(as: FeedRepository)
class FeedRepositoryImpl implements FeedRepository {
  final RemoteFeedDataSource _remoteDataSource;

  FeedRepositoryImpl({required RemoteFeedDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<FeedEntity>>> fetchFeeds(
      {required String afterAt, int take = 20, bool descending = false}) async {
    try {
      return await _remoteDataSource
          .fetchFeeds(afterAt: afterAt, take: take, descending: descending)
          .then((event) => event.map(FeedEntity.fromModel).toList())
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Either<Failure, Stream<List<FeedEntity>>> getFeedStream(
      {required String afterAt, bool descending = false}) {
    try {
      final stream = _remoteDataSource
          .getFeedStream(afterAt: afterAt, descending: descending)
          .asyncMap((event) => event.map(FeedEntity.fromModel).toList());
      return right(stream);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveFeed(FeedEntity entity) async {
    try {
      return await _remoteDataSource
          .saveFeed(FeedModel.fromEntity(entity))
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> saveImages(
      {required feedId, required List<File> images}) async {
    try {
      final futures = List.generate(images.length, (index) async {
        final path = '$feedId/image_$index';
        await _remoteDataSource.uploadFile(path: path, file: images[index]);
        return _remoteDataSource.getDownloadUrl(path);
      });
      return await Future.wait(futures).then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveVideo(
      {required feedId, required File video}) async {
    try {
      final path = '$feedId/video';
      await _remoteDataSource.uploadFile(path: path, file: video);
      return await _remoteDataSource.getDownloadUrl(path).then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }
}
