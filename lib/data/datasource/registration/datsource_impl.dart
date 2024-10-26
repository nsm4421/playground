part of 'datasource.dart';

class RegistrationDataSourceImpl implements RegistrationDataSource {
  final SupabaseClient _supabaseClient;

  RegistrationDataSourceImpl(this._supabaseClient);

  @override
  Future<String> create(
      {required String meetingId, required String introduce}) async {
    // return new registration id
    return await _supabaseClient
        .rpc<String>(RpcFns.createRegistration.name, params: {
      'introduce_to_insert': introduce,
      'meeting_id_to_insert': meetingId,
    });
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
      {required String registrationId, required bool isPermitted}) async {
    customUtil.logger.t(
        'update registration request|id:$registrationId|isPermitted:$isPermitted');
    return await _supabaseClient
        .rpc<void>(RpcFns.updatePermissionOnRegistration.name, params: {
      'registration_id_to_permit': registrationId,
      'is_permitted_to_switch': isPermitted
    });
  }
}
