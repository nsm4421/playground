import 'dart:io';

import 'package:hot_place/core/constant/supbase.constant.dart';
import 'package:hot_place/core/util/image.util.dart';
import 'package:hot_place/data/data_source/feed/feed.data_source.dart';
import 'package:hot_place/domain/model/feed/feed.model.dart';
import 'package:hot_place/domain/model/feed/feed_with_author.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/error/custom_exception.dart';
import '../../../core/error/failure.constant.dart';

class RemoteFeedDataSource extends FeedDataSource {
  final GoTrueClient _auth;
  final PostgrestClient _db;
  final SupabaseStorageClient _storage;

  RemoteFeedDataSource(
      {required GoTrueClient auth,
      required PostgrestClient db,
      required SupabaseStorageClient storage})
      : _auth = auth,
        _db = db,
        _storage = storage;

  final _logger = Logger();

  @override
  Stream<List<FeedWithAuthorModel>> getFeedStream() {
    try {
      return _db
          .from(TableName.feed.name)
          // 유저 계정 테이블과 피드 테이블을 조인
          .select("*, author:${TableName.user.name}(*)")
          // 최신 피드 순으로
          .order('created_at', ascending: false)
          .then((json) =>
              json.map((e) => FeedWithAuthorModel.fromJson(e)).toList())
          .asStream();
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError,
          message: 'error occurs when getting feed');
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.serverRequestFail,
          message: 'error occurs when getting feed');
    }
  }

  @override
  Future<List<FeedWithAuthorModel>> getFeeds(
      {required int skip, required int take}) async {
    try {
      return await _db
          .from(TableName.feed.name)
          // 유저 계정 테이블과 피드 테이블을 조인
          .select("*, author:${TableName.user.name}(*)")
          .range(skip, take)
          // 최신 피드 순으로
          .order('created_at', ascending: false)
          .then((json) =>
              json.map((e) => FeedWithAuthorModel.fromJson(e)).toList());
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError,
          message: 'error occurs when getting feed');
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
      await _db.from(TableName.feed.name).insert(feed.toJson());
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError,
          message: 'error occurs on create feed');
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
      await _db
          .from(TableName.feed.name)
          .update(feed.toJson())
          .match({'id': feed.id});
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError,
          message: 'error occurs on create feed');
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
      await _db.from(TableName.feed.name).delete().match({'id': feedId});
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError,
          message: 'error occurs on create feed');
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
      final currentUid = _auth.currentUser!.id;
      final compressedImage = await ImageUtil.compressImage(image);
      final path = '$currentUid/$feedId/$filename.jpg';
      await _storage.from(BucketName.feed.name).upload(path, compressedImage,
          fileOptions: const FileOptions(
            cacheControl: '3600',
            upsert: true,
          ));
      return _storage.from(BucketName.feed.name).getPublicUrl(path);
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.storageError,
          message:
              'error occurs on uploading image file with filename $filename');
    }
  }
}
