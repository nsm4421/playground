import 'package:logger/logger.dart';
import 'package:my_app/core/constant/dto.constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constant/supabase.constant.dart';
import '../../../core/exception/custom_exception.dart';
import '../../../domain/model/like/like.model.dart';

part 'like.datasource.dart';

class LocalLikeDataSourceImpl implements LocalLikeDataSource {}

class RemoteLikeDataSourceImpl implements RemoteLikeDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  RemoteLikeDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  // 현재 로그인 유저의 id
  String get _getCurrentUidOrElseThrow {
    final currentUid = _client.auth.currentUser?.id;
    if (currentUid == null) {
      throw const AuthException('NOT LOGIN');
    }
    return currentUid;
  }

  @override
  Stream<Iterable<LikeModel>> get likeOnFeedStream => _client
      .from(TableName.like.name)
      .stream(primaryKey: ['id'])
      .eq("createdBy", _getCurrentUidOrElseThrow)
      .asyncMap((event) => event.map(LikeModel.fromJson));

  @override
  Future<void> saveLikeOnFeed(String feedId) async {
    try {
      await _client.rest.from(TableName.like.name).insert(LikeModel(
              id: const Uuid().v4(),
              referenceId: feedId,
              type: LikeType.feed,
              createdAt: DateTime.now().toIso8601String(),
              createdBy: _getCurrentUidOrElseThrow)
          .toJson());
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> deleteLikeOnFeed(String feedId) async {
    try {
      await _client.rest
          .from(TableName.like.name)
          .delete()
          .eq("referenceId", feedId)
          .eq("type", LikeType.feed.name);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> deleteLikeById(String likeId) async {
    try {
      await _client.rest.from(TableName.like.name).delete().eq("id", likeId);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }
}
