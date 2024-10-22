part of 'datasource.dart';

class CommentDataSourceImpl implements CommentDataSource {
  final SupabaseClient _supabaseClient;

  CommentDataSourceImpl(this._supabaseClient);

  @override
  Future<String> create(
      {required Tables refTable,
      required String refId,
      required String content}) async {
    final commentId = const Uuid().v4();
    return await _supabaseClient.from(Tables.comment.name).insert({
      'id': commentId,
      'reference_id': refId,
      'content': content,
      'created_at': customUtil.now,
      'updated_at': customUtil.now,
      'created_by': _supabaseClient.auth.currentUser!.id
    }).then((_) => commentId);
  }

  @override
  Future<Iterable<FetchCommentModel>> fetch(
      {required Tables refTable,
      required String refId,
      required String beforeAt,
      int take = 20}) async {
    return await _supabaseClient
        .rpc<List<Map<String, dynamic>>>(RpcFns.fetchComments.name, params: {
      'reference_table': refTable.name,
      'reference_id': refId,
      'before_at': beforeAt,
      'take': take
    }).then((res) => res.map(FetchCommentModel.fromJson));
  }

  @override
  Future<void> modifyById(
      {required String commentId, required String content}) async {
    return await _supabaseClient.from(Tables.comment.name).update({
      'content': content,
      'updated_at': customUtil.now,
    }).eq('id', commentId);
  }

  @override
  Future<void> modifyByRef(
      {required Tables refTable,
      required String refId,
      required String content}) async {
    return await _supabaseClient
        .from(Tables.comment.name)
        .update({'content': content, 'updated_at': customUtil.now})
        .eq('reference_id', refId)
        .eq('reference_table', refTable.name);
  }

  @override
  Future<void> deleteById(String commentId) async {
    return await _supabaseClient
        .from(Tables.comment.name)
        .delete()
        .eq('id', commentId);
  }

  @override
  Future<void> deleteByRef(
      {required Tables refTable, required String refId}) async {
    return await _supabaseClient
        .from(Tables.comment.name)
        .delete()
        .eq('reference_table', refTable.name)
        .eq('reference_id', refId);
  }
}
