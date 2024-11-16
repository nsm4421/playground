part of 'datasource.dart';

class CommentDataSourceImpl with CustomLogger implements CommentDataSource {
  final SupabaseClient _supabaseClient;

  CommentDataSourceImpl(this._supabaseClient);

  String get _table => Tables.comments.name;

  @override
  Future<void> create(CreateCommentDto dto) async {
    await _supabaseClient.rest.from(_table).insert({
      ...dto.toJson(),
      'created_by': _supabaseClient.auth.currentUser!.id,
      'created_at': DateTime.now().toUtc().toIso8601String(),
      'updated_at': DateTime.now().toUtc().toIso8601String(),
      'deleted_at': null,
    });
  }

  @override
  Future<void> delete(String id) async {
    await _supabaseClient.rest.from(_table).update({
      'deleted_at': DateTime.now().toUtc().toIso8601String(), // soft delete
    }).eq('id', id);
  }

  @override
  Future<Iterable<FetchCommentDto>> fetch(
      {required String beforeAt,
      required String referenceId,
      required String referenceTable,
      int take = 20}) async {
    // TODO : RPC함수 정의
    return await _supabaseClient
        .rpc<List<Map<String, dynamic>>>(RpcFns.fetchReels.name, params: {
      '_before_at': beforeAt,
      '_reference_id': referenceId,
      '_reference_table': referenceTable,
      '_take': take
    }).then((res) => res.map(FetchCommentDto.fromJson));
  }
}
