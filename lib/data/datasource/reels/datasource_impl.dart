part of 'datasource.dart';

class ReelsDataSourceImpl implements ReelsDataSource {
  final SupabaseClient _supabaseClient;

  ReelsDataSourceImpl(this._supabaseClient);

  @override
  Future<Iterable<FetchReelsModel>> fetch(String beforeAt,
      {int take = 20}) async {
    return await _supabaseClient
        .rpc<List<Map<String, dynamic>>>(RpcFns.fetchReels.name, params: {
      'before_at': beforeAt,
      'take': take
    }).then((res) => res.map(FetchReelsModel.fromJson));
  }

  @override
  Future<void> edit(EditReelsModel model, {bool update = false}) async {
    return await _supabaseClient.rest.from(Tables.reels.name).upsert(model
        .copyWith(
            created_at: update ? model.created_at : customUtil.now,
            updated_at: customUtil.now,
            created_by: _supabaseClient.auth.currentUser!.id)
        .toJson());
  }
}
