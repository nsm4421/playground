import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:portfolio/features/feed/data/datasource/feed/feed.datasource_impl.dart';
import 'package:portfolio/features/feed/domain/entity/feed/feed.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main/core/constant/response_wrapper.dart';
import '../model/feed/feed.model.dart';

part '../../domain/repository/feed.repository.dart';

@LazySingleton(as: FeedRepository)
class FeedRepositoryImpl implements FeedRepository {
  final FeedDataSource _dataSource;
  final Logger _logger = Logger();

  FeedRepositoryImpl(this._dataSource);

  @override
  Future<ResponseWrapper<void>> createFeed(FeedEntity entity) async {
    try {
      return await _dataSource
          .createFeed(FeedModel.fromEntity(entity))
          .then((_) => ResponseWrapper.success(null));
    } on PostgrestException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('create feed fails');
    }
  }

  @override
  Future<ResponseWrapper<void>> modifyFeed({
    required String feedId,
    String? content,
    List<String>? media,
    List<String>? hashtags,
  }) async {
    try {
      return await _dataSource
          .modifyFeed(
              feedId: feedId,
              content: content,
              media: media,
              hashtags: hashtags)
          .then((_) => ResponseWrapper.success(null));
    } on PostgrestException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('modify feed fails');
    }
  }

  @override
  Future<ResponseWrapper<void>> deleteFeedById(String feedId) async {
    try {
      return await _dataSource
          .deleteFeedById(feedId)
          .then((_) => ResponseWrapper.success(null));
    } on PostgrestException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('delete feed fails');
    }
  }

  @override
  Future<ResponseWrapper<List<FeedEntity>>> fetchFeeds(
      {required DateTime beforeAt,
      int take = 20,
      bool ascending = true}) async {
    try {
      return await _dataSource
          .fetchFeeds(beforeAt: beforeAt, take: take, ascending: ascending)
          .then((res) => res.map(FeedEntity.fromRpcModel).toList())
          .then(ResponseWrapper.success);
    } on PostgrestException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('delete feed fails');
    }
  }

  @override
  Future<ResponseWrapper<Iterable<String>>> uploadMedia(
      {required String feedId, required Iterable<File> files}) async {
    try {
      return await _dataSource
          .uploadMedia(feedId: feedId, files: files)
          .then(ResponseWrapper.success);
    } on PostgrestException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('upload media fails');
    }
  }
}
