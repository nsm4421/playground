import 'package:supabase_flutter/supabase_flutter.dart';

import '../../dto/auth/user/user.dto.dart';

abstract class RestApi {
  SupabaseStreamBuilder userStreamById(String userId);

  Future<void> insertUser(UserDto user);

  Future<void> updateUser(
      {required String uid, String? nickname, String? profileImage});

  Future<UserDto> findUserById(String id);
}
