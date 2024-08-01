part of "auth.datasource.dart";

class AuthDataSourceImpl implements AuthDataSource {
  final SupabaseClient _client;

  AuthDataSourceImpl(this._client);

  @override
  String get tableName => TableName.account.name;

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
    return await _client.rest.from(tableName).insert(account.toJson());
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
    return await _client.rest.from(tableName).update({
      if (nickname != null) "nickname": nickname,
      if (profileImage != null) "profile_image": profileImage,
    }).eq("id", uid);
  }

  @override
  Future<String> upsertProfileImage(
      {required String uid, required File profileImage}) async {
    final bytes = await profileImage.readAsBytes();
    final fileName = 'profile_image_$uid';
    await _client.storage.from(BucketName.profileImage.name).uploadBinary(
          fileName,
          bytes,
          fileOptions: const FileOptions(
            cacheControl: '3600',
            upsert: true,
          ),
        );
    return _client.storage
        .from(BucketName.profileImage.name)
        .getPublicUrl(fileName);
  }
}
