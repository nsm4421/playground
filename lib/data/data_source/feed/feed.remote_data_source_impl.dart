import 'dart:io';

import 'package:hot_place/core/constant/supbase.constant.dart';
import 'package:hot_place/core/util/image.util.dart';
import 'package:hot_place/domain/model/feed/feed.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/error/custom_exception.dart';
import '../../../core/error/failure.constant.dart';
import 'feed.data_source.dart';

class RemoteFeedDataSourceImpl implements RemoteFeedDataSource {
  final SupabaseClient _client;

  RemoteFeedDataSourceImpl(this._client);

  final _logger = Logger();

  @override
  Stream<List<FeedModel>> getFeedStream() {
    try {
      return _client
          .from(TableName.feed.name)
          .stream(primaryKey: ['id'])
          .order('created_at', ascending: false)
          .asyncMap((event) =>
              event.map((json) => FeedModel.fromJson(json)).toList());
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError, message: err.message);
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.serverRequestFail,
          message: 'error occurs when getting feed');
    }
  }

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
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError, message: err.message);
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.serverRequestFail,
          message: 'error occurs when getting feed');
    }
  }

  @override
  Future<void> createFeed(FeedModel feed) async {
    try {
      await _client.rest.from(TableName.feed.name).insert(feed.toJson());
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError, message: err.message);
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.serverRequestFail,
          message: 'error occurs on create feed');
    }
  }

  @override
  Future<void> modifyFeed(FeedModel feed) async {
    try {
      await _client.rest
          .from(TableName.feed.name)
          .update(feed.toJson())
          .match({'id': feed.id});
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError, message: err.message);
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.serverRequestFail,
          message: 'error occurs on modifying feed which of id is ${feed.id}');
    }
  }

  @override
  Future<void> deleteFeedById(String feedId) async {
    try {
      await _client.rest
          .from(TableName.feed.name)
          .delete()
          .match({'id': feedId});
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError, message: err.message);
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.serverRequestFail,
          message: 'error occurs on delete feed which of id is $feedId');
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
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.storageError,
          message:
              'error occurs on uploading image file with filename $filename');
    }
  }
}
