part of 'datasource.dart';

class ReelsDataSourceImpl with CustomLogger implements ReelsDataSource {
  final SupabaseClient _supabaseClient;

  ReelsDataSourceImpl(this._supabaseClient);

  @override
  Future<void> create({required String id, required CreateReelsDto dto}) async {
    await _supabaseClient.rest.from(Tables.reels.name).insert({
      ...dto.toJson(),
      'id': id,
      'created_by': _supabaseClient.auth.currentUser!.id,
      'created_at': DateTime.now().toUtc().toIso8601String(),
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    });
  }

  @override
  Future<void> delete(String id) async {
    await _supabaseClient.rest.from(Tables.reels.name).delete().eq('id', id);
  }

  @override
  Future<void> edit({required String id, String? caption}) async {
    await _supabaseClient.rest.from(Tables.reels.name).update({
      'caption': caption,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    }).eq('id', id);
  }

  @override
  Future<Iterable<FetchReelsDto>> fetch(
      {required String beforeAt, int take = 20}) async {
    // TODO : RPC 함수 정의하기
    return await _supabaseClient
        .rpc<List<Map<String, dynamic>>>(RpcFns.fetchReels.name, params: {
      '_before_at': beforeAt,
      '_take': take
    }).then((res) => res.map(FetchReelsDto.fromJson));
  }
}
