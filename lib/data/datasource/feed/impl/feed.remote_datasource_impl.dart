import 'dart:io';

import 'package:logger/logger.dart';
import 'package:my_app/domain/model/feed/base/feed_with_author.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constant/database.constant.dart';
import '../../../../core/exception/custom_exception.dart';
import '../../../../domain/model/feed/base/feed.model.dart';

part '../abstract/feed.remote_datasource.dart';

class RemoteFeedDataSourceImpl implements RemoteFeedDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  static const _orderByField = "createdAt";

  RemoteFeedDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  // 피드 이미지/동영상 저장 경로
  String _mediaPath(String feedId) =>
      '$_getCurrentUidOrElseThrow/$feedId/media';

  // 현재 로그인 유저의 id
  String get _getCurrentUidOrElseThrow {
    final currentUid = _client.auth.currentUser?.id;
    if (currentUid == null) {
      throw const AuthException('NOT LOGIN');
    }
    return currentUid;
  }

  @override
  Future<Iterable<FeedWithAuthorModel>> fetchFeeds({
    required DateTime beforeAt,
    bool ascending = false,
    int from = 0,
    int to = 20,
  }) async {
    try {
      assert(from <= to);
      return await _client.rest
          .from(TableName.feed.name)
          .select("*, author:${TableName.user.name}(*)")
          .lt('createdAt', beforeAt)
          .order(_orderByField, ascending: ascending)
          .range(from, to)
          .then((fetched) => fetched.map(FeedWithAuthorModel.fromJson));
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> saveFeed(FeedModel model) async {
    try {
      return await _client.rest.from(TableName.feed.name).insert(model
          .copyWith(
              createdBy: _getCurrentUidOrElseThrow,
              createdAt: DateTime.now().toIso8601String())
          .toJson());
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<String> uploadFile(
      {required String feedId, required File file}) async {
    try {
      await _client.storage.from(BucketName.feed.name).upload(
          _mediaPath(feedId), file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: true));
      return _client.storage
          .from(BucketName.feed.name)
          .getPublicUrl(_mediaPath(feedId));
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> deleteFeed(String feedId) async {
    try {
      await _client.rest.from(TableName.feed.name).delete().eq("id", feedId);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }
}
