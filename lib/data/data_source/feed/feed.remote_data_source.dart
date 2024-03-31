import 'dart:io';

import 'package:hot_place/core/constant/supbase.constant.dart';
import 'package:hot_place/core/util/image.util.dart';
import 'package:hot_place/data/data_source/feed/feed.data_source.dart';
import 'package:hot_place/domain/model/feed/feed.model.dart';
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
  Future<void> createFeed(FeedModel feed) async {
    try {
      await _db.from(Tables.feed.name).insert(feed.toJson());
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
          .from(Tables.feed.name)
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
      await _db.from(Tables.feed.name).delete().match({'id': feedId});
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
      return await _storage
          .from(Buckets.feed.name)
          .upload('$currentUid/$feedId/$filename.jpg', compressedImage,
              fileOptions: const FileOptions(
                cacheControl: '3600',
                upsert: true,
              ));
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.storageError,
          message:
              'error occurs on uploading image file with filename $filename');
    }
  }
}
