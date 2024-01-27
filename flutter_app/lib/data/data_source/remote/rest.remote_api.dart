import 'package:my_app/core/enums/supabase.enum.dart';
import 'package:my_app/data/dto/auth/user/user.dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../base/rest.api.dart';

class RemoteRestApi extends RestApi {
  final SupabaseClient _client;

  RemoteRestApi(this._client);

  @override
  SupabaseStreamBuilder userStreamById(String userId) => _client
      .from(TableName.user)
      .stream(primaryKey: ['id'])
      .eq('uid', userId)
      .limit(1);

  @override
  Future<UserDto> findUserById(String id) async =>
      UserDto.fromJson((await _client.rest
          .from(TableName.user)
          .select()
          .eq('uid', id)
          .limit(1))[0]);

  @override
  Future<void> insertUser(UserDto user) async =>
      await _client.rest.from(TableName.user).insert({
        'uid': user.uid,
        'email': user.email,
        if (user.nickname.isNotEmpty) 'nickname': user.nickname,
        if (user.profileImage.isNotEmpty) 'profile_image': user.profileImage
      });

  @override
  Future<void> updateUser(
          {required String uid,
          String? nickname,
          String? profileImage}) async =>
      await _client.rest.from(TableName.user).update({
        if (nickname != null) 'nickname': nickname,
        if (profileImage != null) 'profile_image': profileImage
      }).eq('uid', uid);
}
