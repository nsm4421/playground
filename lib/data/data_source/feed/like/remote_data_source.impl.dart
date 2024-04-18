import 'package:hot_place/core/constant/supbase.constant.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/data_source/feed/like/remote_data_source.dart';
import 'package:hot_place/domain/model/feed/like/like_feed.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/util/exeption.util.dart';

class RemoteLikeFeedDataSourceImpl implements RemoteLikeFeedDataSource {
  final SupabaseClient _client;

  final Logger _logger;

  RemoteLikeFeedDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

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
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
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
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> cancelLikeById(String likeId) async {
    try {
      await _client.rest.from(TableName.like.name).delete().eq('id', likeId);
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }
}
