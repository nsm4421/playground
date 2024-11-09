part of 'datasource.dart';

class FeedDataSourceImpl with CustomLogger implements FeedDataSource {
  final SupabaseClient _supabaseClient;

  FeedDataSourceImpl(this._supabaseClient);

  String get _table => Tables.feeds.name;

  @override
  Future<void> create({required String id, required CreateFeedDto dto}) async {
    await _supabaseClient.rest.from(_table).insert({
      ...dto.toJson(),
      'id': id,
      'created_by': _supabaseClient.auth.currentUser!.id,
      'created_at': DateTime.now().toUtc().toIso8601String(),
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    });
  }

  @override
  Future<Iterable<FetchFeedDto>> fetch(
      {required String beforeAt, int take = 20}) async {
    // TODO : RPC함수 구현
    return await _supabaseClient
        .rpc<List<Map<String, dynamic>>>(RpcFns.fetchFeeds.name, params: {
      '_before_at': beforeAt,
      '_take': take
    }).then((res) => res.map(FetchFeedDto.fromJson));
  }

  @override
  Future<void> edit({required String id, required UpdateFeedDto dto}) async {
    await _supabaseClient.rest.from(_table).insert({
      if (dto.content != null) 'content': dto.content,
      if (dto.hashtags != null) 'hashtags': dto.hashtags,
      if (dto.captions != null) 'captions': dto.captions,
      if (dto.images != null) 'images': dto.images,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    });
  }

  @override
  Future<void> delete(String id) async {
    await _supabaseClient.rest.from(_table).delete().eq('id', id);
  }
}
