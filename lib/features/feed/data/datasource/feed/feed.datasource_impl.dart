import 'dart:io';

import 'package:logger/logger.dart';
import 'package:portfolio/features/feed/data/model/feed/feed.model.dart';
import 'package:portfolio/features/feed/data/model/feed/feed_model_for_rpc.model.dart';
import 'package:portfolio/features/main/data/datasource/base.datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part "feed.datasource.dart";

class FeedDataSourceImpl implements FeedDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  FeedDataSourceImpl({required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  // TODO: implement tableName
  String get tableName => throw UnimplementedError();

  @override
  FeedModel audit(FeedModel model) {
    // TODO: implement audit
    throw UnimplementedError();
  }

  @override
  Future<void> createFeed(FeedModel model) {
    // TODO: implement createFeed
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFeedById(String feedId) {
    // TODO: implement deleteFeedById
    throw UnimplementedError();
  }

  @override
  Future<Iterable<FeedModelForRpc>> fetchFeeds(
      {required DateTime beforeAt, int take = 20, bool ascending = true}) {
    // TODO: implement fetchFeeds
    throw UnimplementedError();
  }

  @override
  Future<void> modifyFeed(FeedModel model) {
    // TODO: implement modifyFeed
    throw UnimplementedError();
  }

  @override
  Future<Iterable<String>> uploadMedia(
      {required String feedId, required Iterable<File> files}) {
    // TODO: implement uploadMedia
    throw UnimplementedError();
  }
}
