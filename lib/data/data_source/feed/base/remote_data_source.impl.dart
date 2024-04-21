import 'dart:io';

import 'package:hot_place/core/constant/supbase.constant.dart';
import 'package:hot_place/core/util/image.util.dart';
import 'package:hot_place/domain/model/feed/base/feed.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/util/exeption.util.dart';
import 'remote_data_source.dart';

class RemoteFeedDataSourceImpl implements RemoteFeedDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  RemoteFeedDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  Stream<List<FeedModel>> getFeedStream() => _client
      .from(TableName.feed.name)
      .stream(primaryKey: ['id'])
      .order('created_at', ascending: false)
      .asyncMap(
          (event) => event.map((json) => FeedModel.fromJson(json)).toList());

  @override
  Future<List<FeedModel>> getFeeds(
      {required int skip, required int take}) async {
    try {
      return await _client.rest
          .from(TableName.feed.name)
          // 유저 계정 테이블과 피드 테이블을 조인
          .select("*, author:${TableName.user.name}(*)")
          .range(skip, take)
          // 최신 피드 순으로
          .order('created_at', ascending: false)
          .then((data) => data
              .map((json) => FeedModel.fromJson(json).copyWith(
                  user_id: json['user_id'],
                  nickname: json['nickname'],
                  profile_image: json['profile_image']))
              .toList());
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> createFeed(FeedModel feed) async {
    try {
      await _client.rest.from(TableName.feed.name).insert(feed.toJson());
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> modifyFeed(FeedModel feed) async {
    try {
      await _client.rest
          .from(TableName.feed.name)
          .update(feed.toJson())
          .match({'id': feed.id});
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> deleteFeedById(String feedId) async {
    try {
      await _client.rest
          .from(TableName.feed.name)
          .delete()
          .match({'id': feedId});
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<String> uploadFeedImageAndReturnDownloadLink(
      {required String feedId,
      required String filename,
      required File image}) async {
    try {
      final currentUid = _client.auth.currentUser!.id;
      final compressedImage = await ImageUtil.compressImage(image);
      final path = '$currentUid/$feedId/$filename.jpg';
      await _client.storage
          .from(BucketName.feed.name)
          .upload(path, compressedImage,
              fileOptions: const FileOptions(
                cacheControl: '3600',
                upsert: true,
              ));
      return _client.storage.from(BucketName.feed.name).getPublicUrl(path);
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }
}
