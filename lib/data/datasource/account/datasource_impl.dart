part of 'datasource.dart';

class AccountDataSourceImpl implements AccountDataSource {
  final SupabaseClient _supabaseClient;

  AccountDataSourceImpl(this._supabaseClient);

  @override
  Future<bool> isUsernameDuplicated(String username) async {
    return await _supabaseClient.rest
        .from('accounts')
        .select('id')
        .eq('username', username)
        .limit(1)
        .then((res) => res.isNotEmpty);
  }
}
