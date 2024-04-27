import 'package:hot_place/core/constant/supbase.constant.dart';
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
  Stream<Iterable<LikeFeedModel>> getLikeStream() {
    try {
      final currentUid = _getCurrentUidOrElseThrow();
      return _client
          .from(TableName.like.name)
          .stream(primaryKey: ['user_id', 'feed_id'])
          .eq('user_id', currentUid)
          .asyncMap((event) => event.map((e) => LikeFeedModel.fromJson(e)));
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> likeFeed(String feedId) async {
    try {
      final currentUid = _getCurrentUidOrElseThrow();
      await _client.rest.from(TableName.like.name).insert(LikeFeedModel(
          user_id: currentUid, feed_id: feedId, created_at: DateTime.now()));
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> cancelLike(String feedId) async {
    try {
      final currentUid = _getCurrentUidOrElseThrow();
      await _client.rest
          .from(TableName.like.name)
          .delete()
          .eq('user_id', currentUid)
          .eq('feed_id', feedId);
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  String _getCurrentUidOrElseThrow() {
    final currentUid = _client.auth.currentUser?.id;
    if (currentUid == null) {
      throw const AuthException('not login');
    }
    return currentUid;
  }
}
