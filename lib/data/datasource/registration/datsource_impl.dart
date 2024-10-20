part of 'datasource.dart';

class RegistrationDataSourceImpl implements RegistrationDataSource {
  final SupabaseClient _supabaseClient;

  RegistrationDataSourceImpl(this._supabaseClient);

  @override
  Future<String> create(String meetingId) async {
    // return new registration id
    return await _supabaseClient.rpc<String>(RpcFns.createRegistration.name,
        params: {'meeting_id': meetingId});
  }

  @override
  Future<void> deleteByMeetingId(String meetingId) async {
    // auth.uid()=proposer_id 권한설정 되어 있음
    return await _supabaseClient.rest
        .from(Tables.registration.name)
        .delete()
        .eq('meeting_id', meetingId)
        .eq('proposer_id', _supabaseClient.auth.currentUser!.id);
  }

  @override
  Future<Iterable<FetchRegistrationsModel>> fetch(String meetingId) async {
    return await _supabaseClient.rpc<List<Map<String, dynamic>>>(
        RpcFns.fetchRegistrations.name,
        params: {
          'meeting_id_to_fetch': meetingId
        }).then((res) => res.map(FetchRegistrationsModel.fromJson));
  }

  @override
  Future<void> update(
      {required String meetingId, required bool isPermitted}) async {
    // auth.uid()=manager_id로 권한설정 되어 있음
    return await _supabaseClient.rest
        .from(Tables.registration.name)
        .update({'is_permitted': isPermitted}).eq('meeting_id', meetingId);
  }
}
