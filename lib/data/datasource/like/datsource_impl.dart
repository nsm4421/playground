part of 'datasource.dart';

class LikeDataSourceImpl implements LikeDataSource {
  final SupabaseClient _supabaseClient;

  LikeDataSourceImpl(this._supabaseClient);

  String? get _currentUid => _supabaseClient.auth.currentUser?.id;

  @override
  Future<void> create({required Tables refTable, required String refId}) async {
    return await _supabaseClient.rest.from(Tables.like.name).insert({
      'id': const Uuid().v4(),
      'reference_id': refId,
      'reference_table': refTable.name,
      'created_by': _currentUid!,
      'created_at': customUtil.now
    });
  }

  @override
  Future<void> delete({required Tables refTable, required String refId}) async {
    return await _supabaseClient.rest
        .from(Tables.like.name)
        .delete()
        .eq('reference_id', refId)
        .eq('reference_table', refTable.name)
        .eq('created_by', _currentUid!);
  }

  @override
  Future<void> deleteById(String likeId) async {
    return await _supabaseClient.rest
        .from(Tables.like.name)
        .delete()
        .eq('id', likeId);
  }
}
