import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/shared.export.dart';

part 'datasource.dart';

class AccountDataSourceImpl extends AccountDataSource {
  final SupabaseClient _supabaseClient;
  final Logger _logger;

  AccountDataSourceImpl(
      {required SupabaseClient supabaseClient, required Logger logger})
      : _supabaseClient = supabaseClient,
        _logger = logger;

  @override
  Future<bool> checkUsername(String username) async {
    try {
      _logger.d('check username :$username');
      return await _supabaseClient.rest
          .from(Tables.accounts.name)
          .count()
          .eq('username', username)
          .then((cnt) => cnt > 0);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<void> updateAccount({String? username, String? avatarUrl}) async {
    try {
      _logger.d('update account username:$username avatar_url:$avatarUrl');
      await _supabaseClient.rest.from(Tables.accounts.name).update({
        if (username != null) 'username': username,
        if (avatarUrl != null) 'avatar_url': avatarUrl
      }).eq('id', _supabaseClient.auth.currentUser!.id);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }
}
