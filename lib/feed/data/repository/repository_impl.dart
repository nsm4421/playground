import 'dart:io';

import 'package:flutter_app/feed/data/data.export.dart';
import 'package:flutter_app/feed/data/dto/edit_feed.dto.dart';
import 'package:flutter_app/feed/domain/domain.export.dart';
import 'package:flutter_app/shared/shared.export.dart';
import 'package:injectable/injectable.dart';

import '../dto/create_feed.dto.dart';

part 'repository.dart';

@LazySingleton(as: FeedRepository)
class FeedRepositoryImpl extends FeedRepository {
  final FeedDataSource _feedDataSource;
  final StorageDataSource _storageDataSource;

  FeedRepositoryImpl(
      {required FeedDataSource feedDataSource,
      required StorageDataSource storageDataSource})
      : _feedDataSource = feedDataSource,
        _storageDataSource = storageDataSource;

  @override
  Future<RepositoryResponseWrapper<void>> createFeed(
      {required String feedId,
      required String media,
      required String caption}) async {
    try {
      return await _feedDataSource
          .createFeed(CreateFeedDto(id: feedId, media: media, caption: caption))
          .then(RepositorySuccess<void>.from);
    } on Exception catch (error) {
      return RepositoryError<void>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<void>> deleteFeedById(String feedId) async {
    try {
      return await _feedDataSource
          .deleteFeedById(feedId)
          .then(RepositorySuccess<void>.from);
    } on Exception catch (error) {
      return RepositoryError<void>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<void>> editFeed(
      {required String feedId, String? media, String? caption}) async {
    try {
      return await _feedDataSource
          .editFeed(EditFeedDto(id: feedId, media: media, caption: caption))
          .then(RepositorySuccess<void>.from);
    } on Exception catch (error) {
      return RepositoryError<void>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<List<FeedEntity>>> fetchFeeds(
      {required DateTime beforeAt, int limit = 20}) async {
    try {
      return await _feedDataSource
          .fetchFeeds(beforeAt: beforeAt, limit: limit)
          .then((res) => res.map(FeedEntity.from).toList())
          .then(RepositorySuccess<List<FeedEntity>>.from);
    } on Exception catch (error) {
      return RepositoryError<List<FeedEntity>>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<String>> uploadFeedImage(File feedImage,
      {bool upsert = false}) async {
    try {
      return await _storageDataSource
          .uploadImage(
              file: feedImage, bucketName: Buckets.feeds.name, upsert: upsert)
          .then(RepositorySuccess<String>.from);
    } on Exception catch (error) {
      return RepositoryError<String>.from(error);
    }
  }
}
