import 'dart:io';

import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../domain/model/feed/base/feed.model.dart';

part 'feed.datasource.dart';

class LocalFeedDataSourceImpl implements LocalFeedDataSource {}

class RemoteFeedDataSourceImpl implements RemoteFeedDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  static const orderBy = "createdAt";

  RemoteFeedDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  Stream<Iterable<FeedModel>> getFeedStream(
          {required String afterAt, bool descending = false}) =>
      throw UnimplementedError();

  @override
  Future<Iterable<FeedModel>> fetchFeeds(
          {required String afterAt,
          int take = 20,
          bool descending = false}) async =>
      throw UnimplementedError();

  @override
  Future<String> getDownloadUrl(String path) async =>
      throw UnimplementedError();

  @override
  Future<void> saveFeed(FeedModel model) async => throw UnimplementedError();

  @override
  Future<void> uploadFile({required String path, required File file}) async =>
      throw UnimplementedError();
}
