part of 'datsource.dart';

class DiaryDataSourceImpl extends DiaryDataSource {
  final SupabaseClient _supabaseClient;

  DiaryDataSourceImpl(this._supabaseClient);

  @override
  Future<Iterable<FetchDiaryModel>> fetch(String beforeAt,
      {int take = 20}) async {
    return await _supabaseClient
        .rpc<List<Map<String, dynamic>>>(RpcFns.fetchDiaries.name, params: {
      '_before_at': beforeAt,
      '_take': take
    }).then((res) => res.map(FetchDiaryModel.fromJson));
  }

  @override
  Future<void> edit(EditDiaryModel model, {bool update = false}) async {
    return await _supabaseClient.rest.from(Tables.diaries.name).upsert(model
        .copyWith(
            created_at: update ? model.created_at : customUtil.now,
            updated_at: customUtil.now,
            created_by: _supabaseClient.auth.currentUser!.id)
        .toJson());
  }

  @override
  Future<void> deleteById(String id) async {
    return await _supabaseClient.rest
        .from(Tables.diaries.name)
        .delete()
        .eq('id', id);
  }
}
