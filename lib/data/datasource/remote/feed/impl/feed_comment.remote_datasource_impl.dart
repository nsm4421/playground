import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/constant/supabase_constant.dart';
import '../../../../../core/util/exception.util.dart';
import '../../../../model/feed/comment/feed_comment.model.dart';
import '../../../../model/feed/comment/feed_comment_for_rpc.model.dart';
import '../../../base/remote_datasource.dart';

part "../abstract/feed_comment.remote_datasource.dart";

class FeedCommentRemoteDataSourceImpl implements FeedCommentRemoteDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  FeedCommentRemoteDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  String get tableName => TableName.feedComment.name;

  @override
  FeedCommentModel audit(FeedCommentModel model) {
    return model.copyWith(
        id: model.id.isNotEmpty ? model.id : const Uuid().v4(),
        created_by: model.created_by.isNotEmpty
            ? model.created_by
            : _client.auth.currentUser!.id,
        created_at: model.created_at ?? DateTime.now().toUtc());
  }

  @override
  Future<void> createComment(FeedCommentModel model) async {
    try {
      final audited = audit(model);
      await _client.rest.from(tableName).insert(audited.toJson());
      _logger.d(audited);
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  Future<void> deleteCommentById(String commentId) async {
    try {
      await _client.rest.from(tableName).delete().eq("id", commentId);
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  Future<Iterable<FeedCommentModelForRpc>> fetchComments(
      {required DateTime beforeAt,
      required String feedId,
      int take = 20}) async {
    try {
      return await _client
          .rpc<List<Map<String, dynamic>>>(RpcName.fetchComments.name, params: {
            'fid': feedId,
            'before_at': beforeAt.toIso8601String(),
            'take': take
          })
          .then((res) => res.map(FeedCommentModelForRpc.fromJson))
          .then((res) {
            _logger.d(res);
            return res;
          });
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }
}
