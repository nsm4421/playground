part of 'datasource.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final SupabaseClient _supabaseClient;

  AuthDataSourceImpl(this._supabaseClient);

  @override
  Stream<AuthUserModel?> get authStateStream =>
      _supabaseClient.auth.onAuthStateChange.asyncMap((e) {
        try {
          return switch (e.event) {
            AuthChangeEvent.signedIn ||
            AuthChangeEvent.userUpdated ||
            AuthChangeEvent.tokenRefreshed =>
              e.session!.user,
            (_) => null
          };
        } catch (error) {
          customUtil.logger.e(error);
          return null;
        }
      }).asyncMap(AuthUserModel.from);

  @override
  AuthUserModel? get authUser =>
      AuthUserModel.from(_supabaseClient.auth.currentUser);

  @override
  String? get currentUid => authUser?.id;

  @override
  bool get isAuthorized => currentUid != null;

  @override
  Future<AuthUserModel?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String avatarUrl,
  }) async {
    return await _supabaseClient.auth
        .signUp(
            email: email,
            password: password,
            data: {'username': username, 'avatar_url': avatarUrl})
        .then((res) => res.user)
        .then(AuthUserModel.from);
  }

  @override
  Future<AuthUserModel?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return await _supabaseClient.auth
        .signInWithPassword(email: email, password: password)
        .then((res) => res.user)
        .then(AuthUserModel.from);
  }

  @override
  Future<void> signOut() async {
    return await _supabaseClient.auth.signOut(scope: SignOutScope.global);
  }

  @override
  Future<AuthUserModel?> editProfile(
      {String? username, String? avatarUrl}) async {
    // on_edit_profile이라는 RPC함수를 미리 선언
    // auth.users 테이블이 수정되면, public.accounts도 수정됨
    return await _supabaseClient.auth
        .updateUser(UserAttributes(data: {
          if (username != null) 'username': username,
          if (avatarUrl != null) 'avatar_url': avatarUrl
        }))
        .then((res) => res.user)
        .then(AuthUserModel.from);
  }
}
