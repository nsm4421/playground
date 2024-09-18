import 'package:flutter_app/comment/data/dto/fetch_feed_comments.dto.dart';
import 'package:flutter_app/comment/data/dto/save_comment.dto.dart';
import 'package:flutter_app/shared/shared.export.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

part 'datasource.dart';

class CommentDataSourceImpl extends CommentDataSource {
  final SupabaseClient _supabaseClient;
  final Logger _logger;

  CommentDataSourceImpl(
      {required SupabaseClient supabaseClient, required Logger logger})
      : _supabaseClient = supabaseClient,
        _logger = logger;

  @override
  Future<Iterable<FetchParentCommentDto>> fetchParentComments(
      {required String referenceId,
      required Tables referenceTable,
      required DateTime beforeAt,
      int take = 20}) async {
    try {
      return await _supabaseClient.rpc<List<Map<String, dynamic>>>(
          RpcFunctions.fetchParentComments.name,
          params: {
            'reference_id': referenceId,
            'reference_table': referenceTable,
            'before_at': beforeAt.toUtc().toIso8601String(),
            'take': take
          }).then((res) => res.map(FetchParentCommentDto.fromJson));
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<Iterable<FetchChildCommentDto>> fetchChildComments(
      {required String referenceId,
      required Tables referenceTable,
      required String parentId,
      required DateTime beforeAt,
      int take = 20}) async {
    try {
      return await _supabaseClient.rest
          .from(Tables.comments.name)
          .select("*,author:${Tables.accounts.name}(id, username, avatar_url)")
          .eq('reference_id', referenceId)
          .eq('reference_table', referenceTable.name)
          .eq('parent_id', parentId)
          .lt('created_at', beforeAt.toUtc().toIso8601String()) // 내림차순
          .limit(take)
          .order('created_at', ascending: false)
          .then(
              (res) => res.map((json) => FetchChildCommentDto.fromJson(json)));
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<void> saveComment(SaveCommentDto dto) async {
    try {
      _logger.d(
          'save comment request id:${dto.id} reference table:${dto.reference_table}');
      await _supabaseClient.rest.from(Tables.comments.name).insert(dto
          .copyWith(id: dto.id.isNotEmpty ? dto.id : const Uuid().v4())
          .toJson());
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<void> deleteCommentById(String commentId) async {
    try {
      _logger.d('delete comment request comment id:$commentId');
      await _supabaseClient.rest
          .from(Tables.comments.name)
          .delete()
          .eq('id', commentId);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }
}
