import 'package:hot_place/core/constant/supbase.constant.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/data_source/like/like_feed.data_source.dart';
import 'package:hot_place/domain/model/feed/like/like_feed.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/error/custom_exception.dart';
import '../../../core/error/failure.constant.dart';

class RemoteLikeFeedDataSource extends LikeFeedDataSource {
  final SupabaseClient _client;

  RemoteLikeFeedDataSource(this._client);

  final _logger = Logger();

  @override
  Stream<LikeFeedModel?> getLikeStream(String feedId) {
    try {
      final currentUid = _client.auth.currentUser!.id;
      return _client.rest
          .from(TableName.like.name)
          .select()
          .eq('user_id', currentUid)
          .eq('feed_id', feedId)
          .asStream()
          .map((event) =>
              event.isNotEmpty ? LikeFeedModel.fromJson(event.first) : null);
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError, message: 'error occurs on like feed');
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.serverRequestFail,
          message: 'error occurs on like feed');
    }
  }

  @override
  Future<String> likeFeed(String feedId) async {
    try {
      final currentUid = _client.auth.currentUser!.id;
      final likeId = UuidUtil.uuid();
      await _client.rest.from(TableName.like.name).insert(
          LikeFeedModel(id: likeId, user_id: currentUid, feed_id: feedId));
      return likeId;
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError, message: 'error occurs on like feed');
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.serverRequestFail,
          message: 'error occurs on like feed');
    }
  }

  @override
  Future<void> cancelLikeById(String likeId) async {
    try {
      await _client.rest.from(TableName.like.name).delete().eq('id', likeId);
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError,
          message: 'error occurs on delete like');
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.serverRequestFail,
          message: 'error occurs on delete like');
    }
  }
}
