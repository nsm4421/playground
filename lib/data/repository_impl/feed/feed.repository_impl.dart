import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/datasource/feed/base/feed.datasource_impl.dart';
import 'package:my_app/data/entity/feed/base/feed.entity.dart';
import 'package:my_app/domain/model/feed/base/feed.model.dart';

import '../../../core/constant/dto.constant.dart';
import '../../../core/exception/custom_exception.dart';
import '../../../core/exception/failure.dart';

part 'package:my_app/domain/repository/feed/feed.repository.dart';

@LazySingleton(as: FeedRepository)
class FeedRepositoryImpl implements FeedRepository {
  final RemoteFeedDataSource _remoteDataSource;

  FeedRepositoryImpl({required RemoteFeedDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<FeedEntity>>> fetchFeeds({
    required DateTime beforeAt,
    bool ascending = false,
    int from = 0,
    int to = 20,
  }) async {
    try {
      return await _remoteDataSource
          .fetchFeeds(
              beforeAt: beforeAt, ascending: ascending, from: from, to: to)
          .then(
              (fetched) => fetched.map(FeedEntity.fromModelWithAuthor).toList())
          .then(right);
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
  Future<Either<Failure, void>> deleteFeed(FeedEntity feed) async {
    try {
      // TODO : Storage에 저장된 이미지나 동영상 삭제
      return await _remoteDataSource.deleteFeed(feed.id!).then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveMedia(
      {required feedId, required MediaType type, required File file}) async {
    try {
      return await _remoteDataSource
          .uploadFile(feedId: feedId, file: file)
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }
}
