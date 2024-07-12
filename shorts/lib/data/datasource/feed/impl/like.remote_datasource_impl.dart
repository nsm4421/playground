import 'package:logger/logger.dart';
import 'package:my_app/domain/model/like/likeOnFeed.dto.dart';
import 'package:my_app/domain/model/like/save_like_request.dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constant/database.constant.dart';
import '../../../../core/exception/custom_exception.dart';
import '../../../../domain/model/like/delete_like_request.dto.dart';

part '../abstract/like.remote_datasource.dart';

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
  Stream<Iterable<LikeOnFeedDto>> get likeOnFeedStream => _client
      .from(TableName.like.name)
      .stream(primaryKey: ['id'])
      .eq("createdBy", _getCurrentUidOrElseThrow)
      .asyncMap((event) => event.map(LikeOnFeedDto.fromJson));

  @override
  Future<void> saveLike(SaveLikeRequestDto dto) async {
    try {
      await _client.rest.from(TableName.like.name).insert(
          SaveLikeRequestDto(referenceId: dto.referenceId, type: dto.type)
              .toJson());
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> deleteLike(DeleteLikeRequestDto dto) async {
    try {
      await _client.rest
          .from(TableName.like.name)
          .delete()
          .eq('referenceId', dto.referenceId)
          .eq('type', dto.type.name)
          .eq('createdBy', _getCurrentUidOrElseThrow);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> deleteLikeById(String likeId) async {
    try {
      await _client.rest.from(TableName.like.name).delete().eq('id', likeId);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }
}
