part of 'datasource.dart';

class AuthDataSourceImpl with CustomLogger implements AuthDataSource {
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
          return null;
        }
      }).asyncMap((user) => user == null ? null : AuthUserModel.from(user));

  @override
  AuthUserModel? get authUser => _supabaseClient.auth.currentUser == null
      ? null
      : AuthUserModel.from(_supabaseClient.auth.currentUser!);

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
    logger.t(
        'email:$email|password:$password|username:$username|avatarUrl:$avatarUrl}');
    return await _supabaseClient.auth
        .signUp(
            email: email,
            password: password,
            data: {'username': username, 'avatar_url': avatarUrl})
        .then((res) => res.user)
        .then((user) => user == null ? null : AuthUserModel.from(user));
  }

  @override
  Future<AuthUserModel?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return await _supabaseClient.auth
        .signInWithPassword(email: email, password: password)
        .then((res) => res.user)
        .then((user) => user == null ? null : AuthUserModel.from(user));
  }

  @override
  Future<void> signOut() async {
    return await _supabaseClient.auth.signOut(scope: SignOutScope.global);
  }

  @override
  Future<AuthUserModel?> editProfile(
      {String? username, String? avatarUrl}) async {
    final user = await _supabaseClient.auth
        .updateUser(UserAttributes(data: {
          if (username != null) 'username': username,
          if (avatarUrl != null) 'avatar_url': avatarUrl
        }))
        .then((res) => res.user)
        .then((user) => user == null ? null : AuthUserModel.from(user));
    await _supabaseClient.rest.from('ACCOUNTS').update({
      if (username != null) 'username': username,
      if (avatarUrl != null) 'avatar_url': avatarUrl
    }).eq('id', currentUid!);
    return user;
  }
}
