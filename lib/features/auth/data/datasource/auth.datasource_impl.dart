import 'package:logger/logger.dart';
import 'package:portfolio/features/auth/data/model/account.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constant/supabase_constant.dart';

part "auth.datasource.dart";

class AuthDataSourceImpl implements AuthDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  AuthDataSourceImpl({required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  User? get currentUser => _client.auth.currentUser;

  @override
  Stream<AuthState> get authStream => _client.auth.onAuthStateChange;

  @override
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    return await _client.auth
        .signUp(email: email, password: password)
        .then((res) => res.user);
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    return await _client.auth
        .signInWithPassword(email: email, password: password)
        .then((res) => res.user);
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  Future<void> insertAccount(AccountModel account) async {
    return await _client.rest
        .from(TableName.account.name)
        .insert(account.toJson());
  }

  @override
  Future<User?> updateMetaData({String? nickname, String? profileImage}) async {
    return await _client.auth
        .updateUser(UserAttributes(data: {
          if (nickname != null) "nickname": nickname,
          if (profileImage != null) "profile_image": profileImage,
        }))
        .then((res) => res.user);
  }

  @override
  Future<void> updateAccount(
      {required String uid, String? nickname, String? profileImage}) async {
    return await _client.rest.from(TableName.account.name).update({
      if (nickname != null) "nickname": nickname,
      if (profileImage != null) "profile_image": profileImage,
    }).eq("id", uid);
  }
}
