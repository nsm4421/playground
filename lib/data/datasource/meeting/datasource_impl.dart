part of 'datasource.dart';

class MeetingDataSourceImpl implements MeetingDataSource {
  final SupabaseClient _supabaseClient;

  MeetingDataSourceImpl(this._supabaseClient);

  @override
  Future<void> create(EditMeetingModel model) async {
    return await _supabaseClient.from(Tables.meeting.name).insert({
      ...model.toJson(),
      'id': const Uuid().v4(),
      'created_at': customUtil.now,
      'updated_at': customUtil.now,
      'created_by': _supabaseClient.auth.currentUser!.id
    });
  }

  @override
  Future<void> modify(
      {required String id, required EditMeetingModel model}) async {
    return await _supabaseClient.from(Tables.meeting.name).update({
      ...model.toJson(),
      'updated_at': customUtil.now,
      'created_by': _supabaseClient.auth.currentUser!.id
    }).eq('id', id);
  }

  @override
  Future<Iterable<FetchMeetingsModel>> fetch(String beforeAt,
      {int take = 20}) async {
    customUtil.logger.d('beforeAt:$beforeAt|take:$take');
    return await _supabaseClient
        .rpc<List<Map<String, dynamic>>>(RpcFns.fetchMeetings.name, params: {
      '_before_at': beforeAt,
      '_take': take
    }).then((res) => res.map(FetchMeetingsModel.fromJson));
  }

  @override
  Future<Iterable<FetchMeetingsModel>> search(String beforeAt,
      {int take = 20,
      String? hashtag,
      AccompanySexType? sex,
      TravelThemeType? theme}) async {
    customUtil.logger.d(
        'beforeAt:$beforeAt|take:$take|hashtag:$hashtag|sex:${sex?.name}|theme:${theme?.name}');
    return await _supabaseClient
        .rpc<List<Map<String, dynamic>>>(RpcFns.searchMeetings.name, params: {
      '_hashtag': hashtag,
      '_sex': sex?.name,
      '_theme': theme?.name,
      '_before_at': beforeAt,
      '_take': take
    }).then((res) {
      customUtil.logger.t(res.firstOrNull);
      return res.map(FetchMeetingsModel.fromJson);
    });
  }

  @override
  Future<void> deleteById(String id) async {
    return await _supabaseClient.rest
        .from(Tables.meeting.name)
        .delete()
        .eq('id', id);
  }
}
