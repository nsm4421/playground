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
      'created_at': now,
      'updated_at': now,
    });
  }

  @override
  Future<Iterable<FetchFeedResDto>> fetch(FetchFeedReqDto dto) async {
    return await _supabaseClient
        .rpc<List<Map<String, dynamic>>>(RpcFns.fetchFeeds.name, params: {
      ...dto.rpcParam
    }).then((res) => res.map(FetchFeedResDto.fromJson));
  }

  @override
  Future<void> edit({required String id, required UpdateFeedDto dto}) async {
    await _supabaseClient.rest.from(_table).insert({
      if (dto.hashtags != null) 'hashtags': dto.hashtags,
      if (dto.captions != null) 'captions': dto.captions,
      if (dto.images != null) 'images': dto.images,
      'updated_at': now,
    });
  }

  @override
  Future<void> delete(String id) async {
    await _supabaseClient.rest
        .from(_table)
        .update({'deleted_at': now}).eq('id', id);
  }
}
